class Test
  @@class_var = 10
  @class_instance_var  = 1
  #类方法： 两种变量都可以访问
  def self.outclass_var
    puts @@class_var
  end
  def self.outclass_instance_var
    puts @class_instance_var
  end
  #类实例方法： 不能访问类实例变量
  def outclass_var
    puts @@class_var
  end
  def outclass_instance_var
    puts @class_instance_var
  end
end

#如果两个变量不初始化，这里就打印不出来。不知道是不是版本的问题
puts Test.class_variables #=>@@class_var
puts Test.instance_variables #=>@class_instance_var
puts Test.singleton_methods(false).class #=>@class_instance_var
puts Test.instance_methods(false) #=>@class_instance_var

#类变量，可以被子类共享且修改
class SubCls < Test
  @@class_var = 12
end

# 可以看到现在类变量值都被修改了
Test.outclass_var #=>12
SubCls.outclass_var #=>12

# 子类无法继承父类的实例变量
Test.outclass_instance_var #=>1
SubCls.outclass_instance_var #=>空


# 类实例方法不能访问实例变量
Test.new.outclass_var #=>12
Test.new.outclass_instance_var #空

# 再看一下子类，和父类的情况相同
SubCls.new.outclass_var #=>12
SubCls.new.outclass_instance_var #空