---
title: tqdm 进度条
date: 2024-06-20 00:03:48
categories:
  - python
tags:
  - python
  - 进度条
---

全称"taqaddum"，阿拉伯语中的“进展”

样例  
```Python
from tqdm import tqdm
import time
for i in tqdm(range(100)):
    # 假设我们正在进行一些耗时的操作，比如训练深度学习模型
    time.sleep(0.01)
```

```Python
with tqdm(total=100) as pbar:
    for i in range(10):
        # 执行一些耗时的操作
        time.sleep(0.1)
        pbar.update(10)
```

