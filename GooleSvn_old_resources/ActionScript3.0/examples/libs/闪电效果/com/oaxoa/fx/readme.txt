 Lightning.as

 属性：

 speed --  线条震动速度
 isVisible -- 线条是否可见
 amplitude -- 线条震动的振幅
 waveLength -- 线条震动的波长
 thickness -- 线条群的厚度
 maxLength -- 线条群的最大长度
 maxLengthVary -- 线条全的最大长度的最大变化
 color -- 线条颜色
 startX -- 线条群起始的坐标X
 startY -- 线条群起始的坐标Y
 endX -- 线条群结束的坐标X
 endY -- 线条群结束的坐标Y
 steps -- 步进数

 childrenDetaheEnd -- 线条群尾巴是否分叉
 childrenAngleVariation -- 线条群角度的变化量
 childrenProbabilty -- 线条群震动的概率
 childrenProbabiltyDecay -- 线条群震动的概率的衰减量
 childrenLengthDecay -- 线条长度的衰减量
 childMaxGenarations -- 线条最大产生量
 childMaxCount -- 线条群最大计数
 childMaxCountDecay -- 线条群最大计数的衰减量
 childrenSmoothPercentage -- 线条群的光滑度
 childrenLifeSpanMax -- 线条群生命持续的最大时间
 childrenLifeSpanmin -- 线条群生命持续的最小时间

 方法：

 startLifeTimer(); -- 线条震动的开始时间
 killAllChildren(); -- 删除所有线条
 generateChild(); -- 产生线条
 update(); -- 更新每次抖动（这是让闪电动起来的函数）
 render(); -- 渲染
 killSurplus();

 