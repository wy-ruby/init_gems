// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
//
// 可以将app/assets/javascripts, lib/assets/javascripts, vendor/assets/javascripts想象成一个逻辑目录，然后
// rails 的 pipeline 引擎会到逻辑目录里去找这个文件中提到的 js 文件，然后编译到application.js里面去。 但是有
// 个例外，require_tree不会到逻辑目录里去找，而是只到'app/assets/javascripts'里去找。所以即使你用了requre_tree .,
// 你还是需要手动将 lib 和 vendor 里需要的 js 文件包含进来。
// rails指南中也指出了，lib/assets 和 vendor/assets 中的静态资源可以引入程序，但不在预编译的范围内。
//
// 例如，如下的文件：
// app/assets/javascripts/home.js
// app/assets/javascripts/sub/something.js
// lib/assets/javascripts/moovinator.js
// vendor/assets/javascripts/slider.js
// vendor/assets/somepackage/phonebox.js
// 在清单文件中可以这么引用(这里已经省略前面的//和=，否则会编译)：
// require home
// require sub/something
// require moovinator
// require slider
// require phonebox
// 在 Rails 控制台中执行 Rails.application.config.assets.paths，可以查看所有的搜索路径。
//
// require 指令告知 Sprockets 要加载的文件。
// require_tree 指令告知 Sprockets 递归引入指定文件夹（相对路径）中的所有JavaScript/css文件。
// require_directory 指令加载指定文件夹中的所有 JavaScript 文件，但不会递归。
// require_self 可以把当前文件中的 CSS 加入调用 require_self 的位置。如果多次调用 require_self，只有最后一次调用有效。
// Sprockets会按照从上至下的require顺序处理指令，但require_tree引入的文件顺序是不可预期的，不要设想能得到一个期望的顺序，所以
// 不建议使用。如果要确保某些 avaScript文件出现在其他文件之前，就要先在清单文件中引入。注意，require等指令不会多次加载同一个文件。

//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .
