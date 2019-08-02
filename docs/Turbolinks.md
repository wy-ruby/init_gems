  **Turbolinks使浏览您的web应用程序更快。在不增加客户端JavaScript框架复杂性的情况下，获得单页面应用程序的性能优势。使用HTML在服务器端呈现视图，
并像往常一样链接到页面。当您跟踪一个链接时，turbolink会自动获取页面，在它的\<body>中交换，并合并它的\<head>，所有这些操作都不会产生整个页面加载的成本。**
**************

### **Turbolinks 的历史和基本原理**  
1. Rails 里的 Assets Pipeline 会把 JavaScript、StypeSheet等资源都合并成单个文件, 以减少浏览器需要发起的请求数量, 以加速浏览器加载页面的时间    
2. Assets Pipeline 的这种原理导致单个文件本身比较大, 如果每次都是全页刷新, 对加载速度一定会有影响, 所以 DHH 引入 Turbolinks 来解决重复载入和
解析资源文件的时间浪费    
3. 页面加载速度 = 下载资源速度 + 解析资源速度, Turbolinks 解决的主要是解析资源的速度, 当切换页面时, Turbolinks会检查新页面 head 中 link 
与 script 标签, 识别其中带有 data-turbolinks-track 的属性, 如果 src 发生变化, 就重新载入所有页面, 如果没有变化只是用新页面的 body 来替
换老页面的 body 内容, 从而在绝大部分时间里避免每次重复解析和加载 head 中资源文件的时间(这个时间非常耗时)

### **Turbolinks 的缓存机制**
Turbolinks 在每一次访问页面后, 都会缓存当前页面, 默认最多缓存 20 个. 缓存页面有两个用途:  
1. 使用浏览器后退, 前进时, 直接从缓存中取出对应的页面并渲染.  
2. 通过 a 元素点击时, Turbolinks 会率先从缓存中取出页面, 渲染出来, 然后再通过 XMLHttpRequest 取得服务器最新的页面, 再替换掉缓存页, 并渲染最
新的页面.  

**在浏览器后退时, Turbolinks 使用的是 cloneNode(true) 来缓存页面, 这样将导致它替换页面时丢失掉所有的事件绑定, 它必须重新解析执行其中的 script
脚本才能让缓存页面正常工作.**

### **Turbolinks 的处理流程**  
1. 浏览器第一次加载, 或点击刷新: 这种情况保持与浏览器的加载顺序一致.  
2. 点击浏览器后退或前进: 直接调取缓存页面并显示, 不再拉取服务端数据.  
3. 点击页面的 a 元素: 先尝试拉取缓存, 如果有, 渲染缓存页面, 然后同时拉取服务端新页面并替换缓存; 如果没有, 则异步拉取服务端新页面, 缓存之并渲染新页面.

### **Chrome 解析页面步骤**
1. 下载 index.html  
2. 解析 head 标签中的 link 与 script 标签, 如果是带有 src 属性, 阻塞其他逻辑执行, 继续去下载对应的资源并执行. 如果没带, 则直接执行其中的代码逻辑.  
3. 渲染 body 标签的内容, 并解析执行 body 中的 script 标签.  
4. 全部执行完毕, 执行 DOMContentLoaded 事件绑定的逻辑.   
 
**Turbolinks第一次加载时网页执行跟上述是一致, 之后会绑定 Body 下所有的 a 元素的 click 事件, 切换页面时, Turbolinks 将会接管浏览器的页面
加载过程, 采用以下方式:**

### **Turbolinks 解析页面步骤**  
1. 异步加载新页面的 index.html  
2. 解析 head 标签中的 link 与 script 标签, 识别其中带有 data-turbolinks-track 的属性, 如果 src 有变化( 可能性很小 ), 则重载所有页面. 
如果没有变化, 则不进行任何操作.  
3. 解析 head 标签中新的 link 与 script 标签, 加载并执行.  
4. 用新页面的 body 替换老的 body 中的内容, 并执行其中的 script 脚本.    

<font color=red>**注意：**</font>始终确保使用文档 \<head> 中的 \<script> 元素加载应用程序的JavaScript包。否则，turbolink将在每次页面更改时重新加载包。  
如果出于性能原因，传统上将应用程序脚本放在\<body>的末尾，那么可以考虑使用\<script deferred >属性。它有广泛的浏览器支持，并允许您保持您的脚本
在\<head>的turbolink兼容性。

### **Turbolinks的实际使用：**  
 　　说明：下面两行代码是在index展示列表页，show展示列表中某一项的详情页，edit是某一项的编辑页面。  
 　　使用data-turbolinks=false禁用turbolink,禁用后的链接将由浏览器正常处理。  
 ```html
 <td><%= link_to 'Show', user, data: {turbolinks: :false} %></td>
 ```
 　　这里使用了turbolinks这个gem，配置data-turbolinks-action="replace"，在某个页面设置之后再点击绑定该配置的按钮后，不将该页面添加到页面
 访问的历史记录项中，所以即使点击浏览器左上角的回退按钮也不会回退到配置的那个页面。如下在edit按钮上配置后，点击进入edit再回退上一步的时候并不
 会回退到index页面(会返回上上个页面，此时如果再按前进按钮就会重新进入到edit页面，跳过了index页面)，但是其他的没有该配置的按钮可以回退到index。  
 ```html
 <td><%= link_to 'Edit', edit_user_path(user), data: {:turbolinks_action => "replace"} %></td>
 ```
　　要指定一个页面不用缓存：
要完全禁用应用程序中的缓存，请确保每个页面都包含无缓存指令。
```html
<head>
  ...
  <meta name="turbolinks-cache-control" content="no-cache">
</head>
```
　　turbolinks可以在 \<head> 中跟踪资产元素的URL，从一个页面到下一个页面，如果它们发生变化，则会自动发出完全重新加载。这样可以确保用户始终    
拥有应用程序脚本和样式的最新版本。
```html
<head>
  ...
  <link rel="stylesheet" href="/application-258e88d.css" data-turbolinks-track="reload">
  <script src="/application-cbd3cd4.js" data-turbolinks-track="reload"></script>
</head>
```
使某个页面触发完全加载，对于不与turbolinks页面更改进行良好交互的第三方javascript库，此设置可能是有用的解决方案。注意是在\<head>中设置
```html
<head>
  ...
  <meta name="turbolinks-visit-control" content="reload">
</head>
```