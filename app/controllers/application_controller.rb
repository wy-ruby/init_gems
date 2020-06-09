class ApplicationController < ActionController::Base
  # 在应用程序控制器中包含Pundit
  include Pundit
  # 这个会跟踪您是否在控制器操作的任何位置调用了authorize，如果没有调用会报错。
  # after_action :verify_authorized, except: :index
  # 这个会跟踪你是否在控制器中调用policy_scope, 如果没有调用会报错。
  # after_action :verify_policy_scoped, only: :index
  # Pundit引发一个Pundit :: NotAuthorizedError的时候，可以自定义一个方法去处理，
  # 这里是定义了user_not_authorized方法，这个方法在application_controller.rb中
  # 的时候是针对全局的，可以在每个控制器去重写控制。
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  # 如果你的控制器可能无权访问current_user（一般是当前登录的用户的信息，例如devise就是
  # 用该方法代表当前用户的信息），或者你的current_user不是Pundit应该调用的方法（例如
  # 是current_admin）。可以在你的控制器中自定义pundit_user方法去定义当前用户的信息。
  def pundit_user
    current_user
  end


  # 开启csrf(跨站请求伪造)安全防护。请记住，GET和HEAD请求不会被检查。
  protect_from_forgery with: :exception

  # 在所有请求前调用该方法，用来配置i18n中的使用 URL 查询参数来设置区域。
  before_action :set_locale

  def self.default_url_options
    { locale: I18n.locale }
  end

  def set_locale
    I18n.locale = extract_locale_from_path || extract_locale_from_tld ||
        extract_locale_from_header || I18n.default_locale
  end

  # 从顶级域名中获取区域设置，如果获取失败会返回 nil
  # 需要在 /etc/hosts 文件中添加如下设置：
  #   127.0.0.1 application.com
  #   127.0.0.1 application.it
  #   127.0.0.1 application.pl
  def extract_locale_from_tld
    parsed_locale = request.host.split('.').last
    I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : nil
  end

  # 从请求路径的参数中获取区域设置，如果获取失败会返回nil
  def extract_locale_from_path
    parsed_locale = params[:locale]
    I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : nil
  end

  # 从子域名中获取区域设置（例如 http://it.application.local:3000）
  # 需要在 /etc/hosts 文件中添加如下设置：
  #   127.0.0.1 gr.application.local
  def extract_locale_from_subdomain
    parsed_locale = request.subdomains.first
    I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : nil
  end

  # 如果没有显式地为请求设置区域（例如，通过上面提到的各种方式），应用就会尝试推断出所需区域。
  # Accept-Language HTTP 首部指明响应请求时使用的首选语言。浏览器根据用户的语言偏好设置
  # 设定这个 HTTP 首部，这是推断区域设置的首选方案。
  def extract_locale_from_header
    # request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
    # 这里建议使用Rack Locale中间件去实现，这样才能相对更加精准。
    # 参考：https://github.com/rack/rack-contrib/blob/master/lib/rack/contrib/locale.rb
  end

  # 定义日志中要额外添加保存的信息，信息放在 event.payload 的哈希中，可以在 config/environments/* 配置中添加的 custom_options 选项获取。
  def append_info_to_payload(payload)
    super
    payload[:host] = request.host
  end

  # 处理不存在的路由信息。
  def route_not_found
    render file: 'public/404', status: 404
  end

  private

    # 自定义全局用户无权限操作的时候的处理方法
    def user_not_authorized
      flash[:alert] = "You are not authorized to perform this action."
      redirect_to(request.referrer || root_path)
    end
end
