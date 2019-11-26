# rails-api-ninja-lab
Time to get some Rails reps in! In this lab, you're going to set up a full CRUD Rails API for dojos, senseis, and students.

You'll do this in two parts:
1. You'll build out a `one to many` backend featuring dojos that `have_many :senseis`
1. You'll add a Student model to this backend so that dojos `have_many :students, through: :senseis`.

## Initial Setup

1. Fork and clone this repo

2. `rails db:create`


## Models
Next you need to create your first 2 models. Remember, the format is `rails g model Model_Name column_name:data_type etc...`. Our Dojo model will have two columns, "name", which we'll leave as the default string, and "motto" which we'll set as "text":
- `rails g model Dojo name motto:text`

Our Sensei model will have "name" and "image_url" as strings, "wise_quote" as text, and it will reference the id of a dojo:
- `rails g model Sensei name image_url wise_quote:text references:dojo`

Double check your migration files to make sure you didn't have any typos. If you did, fix them now. Then, go to your terminal and write:
- `rails db:migrate`

Next, go to your `app/models` folder and:
- in `dojo.rb` add `has_many :senseis, dependent: :destroy`
- in `sensei.rb` add `belongs_to :dojo`

Great! Now we'll need some data to see if everything is working the way we think.

## Seed Data
Scroll to the top of this repository and open `seed_one.rb`. Copy and paste the data there into your `db/seed.rb` file. Then, run `rails db:seed`.

Let's use the console and Active Record to explore our data. In the terminal type `rails c` to open up the console so we can check our app's database, and using Active Record, check the following:
  - `Dojo.all`
  - `Sensei.all`
  - `Dojo.find(1).senseis`
  - `Dojo.find(2).senseis`
  - `Sensei.first.dojo`
  - `Sensei.second.dojo`
  
> Note: Try adding the Awesome Print gem if you'd like the data to look nicer in your terminal.
  
## Routes
Your data is in the database ready to go, so let's set up some endpoints so it can be accessed. Navigate to your `config/routes.rb` file and add:

```rb
resources :dojo do
  resources :senseis
end
```
Check your routes in the controller with `rails routes`. 

## Controllers
We now have endpoints ready for HTTP calls, but we don't have any logic saying what should happen if those endpoints were hit. Let's set up some controllers to handle that.

Inside the controllers folder, make a folder named `dojos_controller.rb`. Have the DojoController inherit from the ApplicationController, and inside that, set up your `index`, `show`, `create`, `update`, and `destroy` methods. Also, make a private `dojos_params` method.

See how far you can get from using your memory or referencing an old project. Here's the `index` method, just to get the ball rolling.

```rb
class DojosController < ApplicationController
  def index
    @dojos = Dojo.all
    render json: @dojos, include: :senseis, status: :ok
  end
  
  def show
  end
  
  def create
  end
  
  def update
  end
  
  def destroy
  end
  
  private
  
  def dojo_params
  end
end
```

If you get stuck, check the `dojos_controller.rb` file in this repository for help. Additionally, if you were able to figure out the whole thing on your own, please still double check that file and make sure your solution is similar. There are multiple potential solutions, so it's okay if yours looks a little different, but it should be similar to the answer in that file.

Next, make a folder named `senseis_controller.rb` and follow the same steps you followed for `dojos_controller.rb`. Here's the index method again: 

```rb
def index
  @dojo = Dojo.find(params[:dojo_id])
  @senseis = Sensei.where(dojo_id: @dojo.id)
  render json: @senseis, include: :dojo, status: :ok
end
```

Check the `senseis_controller.rb` file in this repository when you either get stuck or think that you've completed it.

## GET SERVED
Make sure everything is saved and launch your rails server with `rails s`. Visit the following:
  - `http://localhost:3000/dojos
  - `http://localhost:3000/dojos/1` 
  - `http://localhost:3000/dojos/2`
  - `http://localhost:3000/dojos/1/senseis`
  - `http://localhost:3000/dojos/2/senseis`
  - `http://localhost:3000/dojos/1/senseis/1`
  - `http://localhost:3000/dojos/1/senseis/2`
  
If you see the appropriate JSON data at each of these endpoints, congrats! You've completed part 1 of this lab. Slack your instructors and await further instruction.

# End of Part 1

<hr>

# Part 2
We're going to work through this together, so please don't work ahead on this section unless you're instructors have directed you to do so.

We're now going to add a Student model to our database and create a `has_many :through` relationship. Let's get started:

## Add to Models
In your terminal, add the Student model with:
- `rails g model Students name age:integer special_attack sensei:references`

Go to your `db/migrations` folder and double check the migration file for typos. If everything looks good, add the model to your database with `rails db:migrate`.

Now, let's define the relationship between our three tables by adding the following:
- in `app/models/dojo.rb` add `has_many :students, through: :senseis`
- in `app/models/sensei.rb` add `has_many :students, dependent: :destroy`
- in `app/models/student.rb` add `belongs_to :sensei`

## Add to Seed Data
Copy the seed data from `seed_two.rb` and add it below the original seed data in your `db/seed.rb` file.

- Next, run `rails db:reset`. You **do not** need to run `rails db:seed` after this command; it will happen automatically.

In the terminal, type `rails c` to open up the console to check your app's updated database. Using active record, check the following:
  - `Dojo.find(1).students`
  - `Dojo.find(2).students`
  - `Sensei.first.students`
  - `Sensei.second.students`
  - `Dojo.first.senseis.first.students`
  
Awesome! Now lets set up some endpoints so our newly thicc data can be accessed.

## Set up Routes
In config/routes.rb, add `:students` as a nested route within `:senseis`:
```
resources :dojo do
  resources :senseis do 
    resources :students 
  end
end
```

Check your routes in the controller with `rails routes`. Take a look at how the nested models are reflected in the URLs.

## Add StudentsController
Time to set up some logic for our student model. Add a `students_controller.rb` file to your `app/controllers` folder. Like before, see if you can use your other controllers to figure out what needs to go here. On your get routes, try to `include:` both `sensei` and `dojo` data when you return the students JSON. You may have to look up the sytax for this. 

Once again, if you get stuck, or if you think you've solved it, check the `students_controller.rb` file in this repository for guidance.

## GET SERVED AGAIN
Make sure everything is saved and launch your rails server with `rails s`. Visit the following:
  - `http://localhost:3000/dojos/1/senseis/1/students`
  - `http://localhost:3000/dojos/1/senseis/2/students`
  - `http://localhost:3000/dojos/1/senseis/3/students`
  - `http://localhost:3000/dojos/1/senseis/4/students`
  
Make sure you see the right JSON data at each of these endpoints. Once everything looks good, we just need to take our final step, setting up CORS.

## CORS Correcting
In your Gemfile, un-comment the line `gem 'rack-cors'`. Then, in your terminal, run `bundle install`.

Next, navigate to `config/initializers/cors.rb` and uncomment the entire `Rails.application.config.middleware...end` block. Make sure the origins are set to `"*"` for all.

YOU'VE DONE IT!