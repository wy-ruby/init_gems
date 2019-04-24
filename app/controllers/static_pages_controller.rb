class StaticPagesController < ApplicationController
  def home
    @test = ENV["HOME"]
  end
end
