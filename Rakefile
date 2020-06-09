# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks

# 用来配置 rdoc 用来生成文档。
# 执行 rails rerdoc 就可以生成了，文档将会到 配置项中设置的 rdoc_dir 目录。
# 访问可以直接找到对应的文件夹，直接在浏览器中打开index.html文件进行访问。也可以直接根目录下访问 doc/index.html
require "sdoc"
require "rdoc/task"

rdoc_files = %w[
  README.md
  app/models
  app/controllers
  app/helpers
]

RDoc::Task.new do |rdoc|
  rdoc.rdoc_dir = "public/doc"
  rdoc.generator = "sdoc"
  rdoc.template = "rails"
  rdoc.main = "README.md"
  rdoc.rdoc_files.include(*rdoc_files)
end