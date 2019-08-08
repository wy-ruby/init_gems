// 在config/initializers/assets中配置了清单文件admin.js，所以该文件可以被编译。
// 在admin.js预编译文件中引入了自身和lib/assets/javascripts/check.js文件，注意该文件不会体现在控制台的head中，
// 控制台中只会显示admin这个编辑后的文件。
// require_self
// require check
// document.write("the file in app/assets/javascripts/admin.js");