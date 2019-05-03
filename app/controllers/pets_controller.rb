class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do
    @owners = Owner.all 
    erb :'/pets/new'
  end


  post '/pets' do 

    @pet = Pet.create(params[:pet])
    if !params["owner"]["name"].empty?
      
      @pet.owner = Owner.create(name: params["owner"]["name"])
      @pet.save
    end
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    @owner = @pet.owner
    erb :'/pets/show'
  end

  patch '/pets/:id' do 
    @pet = Pet.find(params[:id])
    @owner = @pet.owner
    # @pet.update(params["owner_id"])
    if !params["pet"]["name"].empty?
      @pet.update(name: params["pet"]["name"])
      # binding.pry
    end
    redirect to "pets/#{@pet.id}"
  end

   get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    @owners = Owner.all 
    @owner = @pet.owner
    erb :'/pets/edit'
  end
end