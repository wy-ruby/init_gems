# 括号中添加的字符串，是启动的时候必须要验证的初始化配置的环境变量，如果没有初始化设置该变量的话会报错。
Figaro.require_keys("DATABASE_PASSWORD", "REDIS_PASSWORD")