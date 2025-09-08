### Microsites ### 

Microsites as defined by me are websites that optimize for data retieval on a small screen device. In bullet form, these are the characteristics:  

* minimal javascript or dynamic client-side rendering
* minimal styling and animations
* core site data available with zero clicks or user interaction.
* minimal payload delivered to the device

This reference implementation usses [Jekyll](https://jekyllrb.com/) to statically build sailing times for the King County water taxis. 

#### Pending ####

The final bullet above has not been implemented. I will introduce Webpack at some point to minimize the delivered payload.

#### Deployment ####  

We use two buildpacks to create a dyno.

* ruby buildpack because Jekyll runs on ruby

* [nginx buildpack](https://github.com/heroku/heroku-buildpack-nginx/blob/main/STATIC.md) because the site is static and we need a web server to serve it.