class CatsController < ApplicationController
  before_action :set_cat, only: [:show, :edit, :update, :destroy]
  skip_after_action :verify_authorized, only: :dashboard
  after_action :verify_policy_scoped, only: :dashboard

  #list all the cats
  def dashboard
    @cat = Cat.new
    @cats = policy_scope(Cat)
  end

  #list one cat = id
  def show
    authorize @cat
  end

  #to show the form = jump to the new.html.erb
  def new
    skip_authorization
    @cat = Cat.new
  end

  #save function
  def create
    @cat = Cat.new(cat_params)
    authorize @cat
    if @cat.save
      redirect_to cat_path(@cat) #redirect back to #show aka cat id
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    cat.update(cat_params)
    redirect_to cat_path(@cat)
  end

  def destroy
    cat.destroy
    redirect_to cat_path, status: :see_other
  end

  private

  def cat_params
    params.require(:cat).permit(:name, :gender, :age, :breed, :microchip_number, :photo_url, :address, :color, :temperament, :description)
  end

  def set_cat
    @cat = Cat.find(params[:id])
  end
end


# ->home ->sign in -> dashboard with all the cats
# -> add a new cat


# -> choose to see one cat - show cat_id
#  --> #edit/update a cat
#  --> delete a cat
