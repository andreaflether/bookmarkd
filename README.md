<img src="./app/assets/images/bookmark-regular.svg" width="10%" align="right">

# Bookmarkd ![Maintainability](https://api.codeclimate.com/v1/badges/d3b4fd47ba56eafc4d50/maintainability) [![codecov](https://codecov.io/gh/andreaflether/bookmarkd/branch/main/graph/badge.svg)](https://codecov.io/gh/andreaflether/bookmarkd) [![GitHub license](https://img.shields.io/github/license/andreaflether/bookmarkd)](https://github.com/andreaflether/bookmarkd/blob/main/LICENSE)

> Since Twitter only provides a single page to keep **all** your bookmarked tweets and usually, it takes forever to find a specific tweet in the middle of it all, extreme measures had to be taken. So, i present to you...

**Bookmarkd**! With it, you can create as many folders as you want and add the tweets of your choice, by just pasting the tweet link :)

## Main features
### 📂 Save tweets of your choice in folders (a.k.a. Bookmark Folders)
Create folders by adding a name and a description. After that, just start adding tweets to it! The bookmarks will always be displayed in the order they were last added.
### 🌓 Dark and Light mode
The default is the Dark mode, but you can change the application mode at any time. 
### 🔢 Sort folders by Name, Last Update or Number of Bookmarks
The folders in the index page, by default, are sorted by the date they were last updated at, but you can also sort them by Name or by the Number of Bookmarks.
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
- [ActiveRecord TypedStore](https://github.com/byroot/activerecord-typedstore) to save user preferences.
- [Cursor Paginate](https://github.com/otoyo/cursor-paginate) for cursor pagination on bookmarks display in a folder.
- [Data Confirm Modal](https://github.com/ifad/data-confirm-modal) for custom and good looking data-confirmations via Bootstrap modals, avoiding the default behavior (Javascript's *"Alert()"*).
- [Devise](https://github.com/heartcombo/devise) for user authentication with the default modules.
- [Friendly ID](https://github.com/norman/friendly_id) for custom URLs on Folder resources, using the name given by the user + a 4 digit random number, instead of using only the ID.
- [Kaminari](https://github.com/kaminari/kaminari) + [Bootstrap 4 Kaminari Views](https://github.com/KamilDzierbicki/bootstrap4-kaminari-views) for pagination.
- [Omniauth Twitter](https://github.com/arunagw/omniauth-twitter) combined with Devise's Omniauthable module to allow a user to sign in via Twitter.
- [PG](https://deveiate.org/code/pg/) (Ruby interface to the [PostgreSQL RDBMS](http://www.postgresql.org/)).
- [Ransack](https://github.com/activerecord-hackery/ransack) to easily search folders in the 'Quick access' feature.
- [Rest Client](https://github.com/rest-client/rest-client) for easier integration with the [oEmbed service](https://developer.twitter.com/en/docs/twitter-for-websites/timelines/guides/oembed-api), provided by Twitter API. 
- [Simple Form](https://github.com/heartcombo/simple_form) to write muss less code when it comes to forms, by using their custom wrappers (especifically Bootstrap).
- [Webpacker](https://github.com/rails/webpacker) + [Yarn](https://classic.yarnpkg.com/) for package management (check [packages](#Packages)).

### Packages 
- [Bootstrap](https://getbootstrap.com/) for design and responsiveness. Other Boostrap related packages were also used, such as:
    - [Bootstrap MaxLength](https://github.com/mimo84/bootstrap-maxlength) for a better and readable indication to the user when a input has a specified max-length in it.
    - [Bootstrap Show Password](https://github.com/wenzhixin/bootstrap-show-password) to allow the user to show/hide the value in a input with the password type. 
- [EasyAutocomplete](http://easyautocomplete.com/) to show results as the user types, in the 'Quick access' feature.
- [ImagesLoaded](https://github.com/desandro/imagesloaded) and [Isotope](https://isotope.metafizzy.co/): 
    - Display folders in a grid layout and show a smooth animation when performing a action on a folder (pin/unpin/delete). 
    - Sort folders by Name, Updated At and Number of Bookmarks.
    - Filter (Search) a folder.
- [Font Awesome](https://fontawesome.com/) for icons.
- [JQuery](https://jquery.com/) and [JQuery UI](https://jqueryui.com/) to simplify Javascript functions and an easier integration with Ajax. 
- [Tippy](https://atomiks.github.io/tippyjs/) to display sum up guides in tooltip form, in order to help the user understand on how the application works.
- [Toastr](https://github.com/CodeSeven/toastr) (with modified design) for alerts and/or notices.

 Check <kbd>[package.json](./package.json)</kbd> file
