a = Object.new
def a.hello
  "hello"
end

# a.dup.hello   # raises NoMethodError
a.clone.hello # return "hello"


class Foo
  attr_accessor :bar
end

o = Foo.new
o.freeze

# o.dup.bar = 10   # succeeds
# o.clone.bar = 10 # raises RuntimeError

class De
end
def De.hello
  p "hello"
end

De.hello
De.clone.hello

s = "cat"
def s.upcase
  "CaT"
end
s_dup = s.dup
s_clone = s.clone

arr1 = [ 1, "flipper", 3 ]
arr2 = arr1.clone
arr2[2] = 99
arr2[1][2] = 'a'
p arr1 #=> [1, "flapper", 3]
p arr2 #=> [1, "flapper", 99]

class Object
  def dclone
    case self
    when Integer,Float,NilClass,FalseClass,
        TrueClass
      klone = self
    when Hash
      klone = self.clone
      self.each{|k,v| klone[k] = v.dclone}
    when Array
      klone = self.clone
      klone.clear
      self.each{|v| klone << v.dclone}
    else
      klone = self.clone
    end
    klone.instance_variables.each {|v|
      klone.instance_variable_set(v, klone.instance_variable_get(v).dclone)
    }
    klone
  end
end

a = [234, 32, [12, 34]]
b = a.dclone
b[2][1] = 654
p a, b