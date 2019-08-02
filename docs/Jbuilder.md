　　**jbuilder为您提供了一个简单的DSL来声明JSON结构，也可以直接将其用作ActionView模板语言。
例如：rails项目中引入后一般也自动会在views下生成对应的.jbuilder文件。**
### 使用：
可以在终端使用命令查看其帮助方法
```shell
rails g jbuilder -h
```
创建jbuilder文件，使用命令：
```ruby
rails g jbuilder Test
````
会生成下列文件,注意一般是三个文件，一个是和创建的文件夹同名只是前面加了-的文件，一个是index，一个是show文件：
```shell
create  app/views/tests
create  app/views/tests/index.json.jbuilder
create  app/views/tests/show.json.jbuilder
create  app/views/tests/_test.json.jbuilder
```
还可以生成jbuilder的时候指定字段，例如：
```ruby
rails g jbuilder Test name:string
```
就可以在_test.json.jbuilder文件中看到有name字段的展现了。   
定义数组并从对象中提取属性放入该数组中：
```ruby
# @people = People.all
json.array! @people, :id, :name
# => [ { "id": 1, "name": "David" }, { "id": 2, "name": "Jamie" } ]
 
json.array! @users do |item| 
  json.id item.id
  json.name item.name
end
# => [{"id":1, "name":"wangyun"}]
``` 
动态定义属性和结构名：
```ruby
json.set! :author do
  json.set! :name, 'David'
end
# => {"author": {"name": "David"}}
```
合并一个哈希或者数据数据到当前的数据中:
```ruby
hash = { author: { name: "David" } }
json.post do
  json.title "Merge HOWTO"
  json.merge! hash
end
# => {"post": { "title": "Merge HOWTO", "author": { "name": "David" } }}
```
防止空值输出,可以在开头去使用 **ignore_nil!** 方法
```ruby
json.ignore_nil!
json.foo nil
json.bar "bar"
# => { "bar": "bar" }
```
使用缓存 **cache!** 实际上它是调用的 **Rails.cache**
```ruby
json.cache! ['v1', @person], expires_in: 10.minutes do
  json.extract! @person, :name, :age
end
# 使用判断cache_if!方法
json.cache_if! !admin?, ['v1', @person], expires_in: 10.minutes do
  json.extract! @person, :name, :age
end
```
使用局部片段 **partial**
```ruby
# 例如要把片段 view/comments/_comments.json.jbuilder 载入到当前页面中。
json.partial! 'comments/comments', comments: @message.comments
json.array! @posts, partial: 'posts/post', as: :post
json.partial! 'posts/post', collection: @posts, as: :post
json.partial! partial: 'posts/post', collection: @posts, as: :post
json.comments @post.comments, partial: 'comments/comment', as: :comment

json.partial! @comment, as: :comment
```