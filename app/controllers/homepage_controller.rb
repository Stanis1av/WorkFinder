class HomepageController < ApplicationController
  def index
    @resumes = resumes
    @query = query
  end

  private

  def resumes
    if query
      Resume.where("headline ILIKE ?", "%#{query}%")

      # Resume.joins(:skills).where("name ILIKE ?", "%#{query}%")
    else
      Resume.all
    end
  end

  def query
    params[:query]
  end
end
