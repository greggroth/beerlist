class UsersController < ApplicationController
  cache_sweeper :users_sweeper, :only => [:create, :update, :destroy]
end