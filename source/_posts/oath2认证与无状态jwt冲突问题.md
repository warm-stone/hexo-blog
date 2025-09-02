---
title: oath2认证与无状态jwt冲突问题
date: 2025-08-11 22:20:34
categories:
tags:
  - web认证
  - oauth2
  - csrf
  - 无状态请求
---

### 背景


 `oauth2` 登录认证时与无状态（不记录session）模式冲突，
1.  `csrf` 开启时，回导致跨域问题
2. 默认实现`oauth2Login`与自定义`token`颁发无法一步无法完成，无状态会导致服务器无法记录用户请求，无限重定授权、验证、默认三个链接 

由于目前`oauth2Login`默认实现没有开放授权端点的全部配置，与其重写相关类，不如自定义实现所有环节
1. 自定义实现可以避免登录过滤器的URL占用
2. 可以避免多次重定向
3. 可以从始至终保持无状态  

在重写`oauth2Login`的方案下，达成以上目标的工作量远超重写

参考： https://www.jessym.com/articles/stateless-oauth2-social-logins-with-spring-boot
此参考在授权部分重写授权客户端的部分，重写了授权客户端管理类用作用户信息持久化，对接口有破坏性，可以参考

以下是 `6.4.5`的官方配置，整体流程基于`session`存储信息， `authorizationRequest` 阶段可以可以自定义存储，
受限于存储原因和接口入参无法获取`response`，整体上无法保持无状态认证完毕后客户端持有认证信息。使用`session` 认证可以选择配置`userService`
```java
@Configuration
@EnableWebSecurity
public class OAuth2LoginSecurityConfig {

	@Bean
	public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
		http
			.oauth2Login(oauth2 -> oauth2
			    // 客户端信息存储
			    .clientRegistrationRepository(this.clientRegistrationRepository())
			    // 自定义存储，仅限于认证阶段
			    .authorizedClientRepository(this.authorizedClientRepository())
			    .authorizedClientService(this.authorizedClientService())
			    .loginPage("/login")
			    .authorizationEndpoint(authorization -> authorization
			        .baseUri(this.authorizationRequestBaseUri())
			        .authorizationRequestRepository(this.authorizationRequestRepository())
			        .authorizationRequestResolver(this.authorizationRequestResolver())
			    )
			    .redirectionEndpoint(redirection -> redirection
			        .baseUri(this.authorizationResponseBaseUri())
			    )
			    .tokenEndpoint(token -> token
			        .accessTokenResponseClient(this.accessTokenResponseClient())
			    )
			    .userInfoEndpoint(userInfo -> userInfo
			        .userAuthoritiesMapper(this.userAuthoritiesMapper())
			        // 获取授权服务器用户信息
			        .userService(this.oauth2UserService())
			        // 登出授权服务器
			        .oidcUserService(this.oidcUserService())
			    )
			);
		return http.build();
	}
}
```
