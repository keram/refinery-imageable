# Imageable Engine for Refinery CMS

## About

Imageable allows you to relate one or more images to any model in Refinery which makes it really easy for you to create simple image galleries with lightbox style popups on the front end page views.

## Requirements

* refinerycms >= 2.718.0

## Features

* Ability to select one or more images from the image picker and relate them to a page
* Reordering support, simply drag into order
* Optionally include captions with each image.

## Install

Add this line to your applications `Gemfile`

```ruby
gem 'refinerycms-imageable', '~> 0.0.1'
```

Next run

```bash
bundle install
rails generate refinery:imageable
rake db:migrate
```

Now when you start up your Refinery application, edit a page and there should be a new "Images" tab.

## Usage

`app/views/refinery/pages/show.html.erb`

If you don't have this file then Refinery will be using its default. You can override this with

```bash
rake refinery:override view=refinery/pages/show
```

```erb
<% content_for :body do %>
  <ul id="gallery">
    <% @page.images.each_with_index do |image, index| %>
      <li>
        <%= link_to image_tag(image.thumbnail("200x200#c").url), image.thumbnail("900x600").url %>
        <span class="caption"><%= image.caption %></span>
      </li>
   <% end %>
  </ul>
<% end %>
<%= render partial: "/refinery/content_page" %>
```
