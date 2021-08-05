Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # (1) The added :new gives us access to authors/:author_id/posts/new, and the `new_author_post_path` 
  # (2) We don't need to make a nested resource route for :create because the form_for(@post) helper will authomatically route to :create for a new Post. 
  resources :authors, only: [:show, :index] do
    resources :posts, only: [:show, :index, :new, :edit] 
  end

  resources :posts
end
