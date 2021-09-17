# Bluethumb Blog

Running [here](https://anewman15-bluethumb-blog.herokuapp.com/)

## Local Deployment

### Getting Started

1. Navigate to a directory of your choice and get a local copy from [this repo](https://github.com/anewman15/bluethumb-blog/)
2. `cd` into your cloned folder.

### Setup

Install gems with:

```
bundle install
```

Setup database with:

```
   rails db:create
   rails db:migrate
```

### Usage

Start server with:

```
    rails server
```

1. Open `http://localhost:3000/` in your browser
2. Start `blog-server` on port 4000 with `shotgun -p 4000`. Otherwise it can't show the posts and comments pages

## Testing
1. Run `bundle exec rspec spec/`