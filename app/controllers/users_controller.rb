class UsersController < ApplicationController

	def show 
		@user = User.find(params[:id])
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(params[:user])
		if @user.save
			SignupMailer.confirm_email(@user).deliver
			redirect_to @user, notice: 'Cadastro criado com sucesso'
		else
			render action: :new
		end
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update
			redirect_to @user, notice: 'Cadastro atualizado com sucesso'
		else
			render action: :edit
		end
	end

end