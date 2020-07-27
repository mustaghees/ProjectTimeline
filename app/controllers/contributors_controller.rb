class ContributorsController < ApplicationController
    before_action :authenticate_admin!, except: [:index]
    before_action :set_contributor, only: [:edit, :update]

    def index
        @contributors = Contributor.all
    end

    def edit
        @technologies = []
        Technology.select{ |t| @technologies << {id: t.id, title: t.title} }

        respond_to do |format|
            format.js
        end
    end

    def create
        new_contrib = Contributor.new(permitted_params)

        if new_contrib.save
            flash[:success] = new_contrib.name + ' created!'
        else
            flash[:danger] = new_contrib.name + ' could not be created!'
            flash[:danger] += " <strong>#{new_contrib.errors.full_messages[0]}</strong>" 
        end

        redirect_to request.referrer
    end

    def update
        if @contributor.update_attributes(permitted_params)
            flash[:success] = @contributor.name + ' updated!'
        else
            flash[:danger] = @contributor.name + ' could not be updated!'
            flash[:danger] = " <strong>#{@contributor.errors.full_messages[0]}</strong>"
        end

        redirect_to request.referrer
    end

    def destroy
        contributor = Contributor.find(params[:id])

        if contributor.destroy
            flash[:success] = contributor.name + ' deleted!'
        else
            flash[:danger] = 'Could not delete. Something went wrong.'
        end

        redirect_to request.referrer
    end

    private
        def set_contributor
            @contributor = Contributor.find_by(id: params[:id])
        end

        def permitted_params
            params.require(:contributor).permit(:name, :image, :email, :join_date, :left_date, :description)
        end
end
