# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
# rails默认是把所有不同类型的静态文件（js、css）都编译到一个application.xx文件中，使用下面的配置可以让其编译到多个文件中。
# 注意虽然会默认编译到application.xx下，但是如果没有app/assets/xx/application.xx文件的话，并不会编译到application.xx下的。
Rails.application.config.assets.precompile += %w(admin.js admin.css)
