<img src="./app/assets/images/bookmark-regular.svg" width="10%" align="right">

# Bookmarkd

> Since Twitter only provides a single page to keep **all** your bookmarked tweets and usually, it takes forever to find a specific tweet in the middle of it all, extreme measures had to be taken. So, i present to you...

**Bookmarkd**! With it, you can create as many folders as you want and add the tweets of your choice, by just pasting the tweet link :)

## Main features
### 📂 Save tweets of your choice in folders (a.k.a. Bookmark Folders)
Create folders by adding a name and a description to it. After that, just start adding tweets to it! The folders in the index page are ordered by the date they were last modified at.
### ✋ No repeated bookmarks
Bookmarkd will tell you if the tweet you're trying to add already exists in the current folder.
### 📌 Pin folders
You can also pin a folder. They will always appear first in the index page.
### 👩‍💻  Sign up via Bookmarkd or Twitter
It is possible to create an account on the site or log in via Twitter.
### 🔒 Private bookmarks
Only you have access to your folders/bookmarked tweets.

## Technology
* Ruby 2.5.5
* Rails 5.2.4

### Gems
- [Data Confirm Modal](https://github.com/ifad/data-confirm-modal) for custom and good looking data-confirmations via Bootstrap modals, avoiding the default behavior (Javascript's *"Alert()"*).
- [Devise](https://github.com/heartcombo/devise) for user authentication with the default modules.
- [Friendly ID](https://github.com/norman/friendly_id) for custom URLs on Folder resources, using the name given by the user + a 4 digit random number, instead of using only the ID.
- [Kaminari](https://github.com/kaminari/kaminari) + [Bootstrap 4 Kaminari Views](https://github.com/KamilDzierbicki/bootstrap4-kaminari-views) for pagination.
- [Omniauth Twitter](https://github.com/arunagw/omniauth-twitter) combined with Devise's Omniauthable module to allow a user to sign in via Twitter.
- [PG](https://deveiate.org/code/pg/) (Ruby interface to the [PostgreSQL RDBMS](http://www.postgresql.org/)).
- [Rest Client](https://github.com/rest-client/rest-client) for easier integration with the [oEmbed service](https://developer.twitter.com/en/docs/twitter-for-websites/timelines/guides/oembed-api), provided by Twitter API. 
- [Simple Form](https://github.com/heartcombo/simple_form) to write muss less code when it comes to forms, by using their custom wrappers (especifically Bootstrap).
- [Webpacker](https://github.com/rails/webpacker) + [Yarn](https://classic.yarnpkg.com/) for package management (check [packages](#Packages)).

### Packages 
- [Bootstrap](https://getbootstrap.com/) for design and responsiveness. Other Boostrap related packages were also used, such as:
    - [Bootstrap MaxLength](https://github.com/mimo84/bootstrap-maxlength) for a better and readable indication to the user when a input has a specified max-length in it.
    - [Bootstrap Show Password](https://github.com/wenzhixin/bootstrap-show-password) to allow the user to show/hide the value in a input with the password type. 
- [JQuery](https://jquery.com/) and [JQuery UI](https://jqueryui.com/) to simplify Javascript functions and an easier integration with Ajax. 
- [Toastr](https://github.com/CodeSeven/toastr) (with modified design) for alerts and/or notices.

 Check <kbd>[package.json](./package.json)</kbd> file
