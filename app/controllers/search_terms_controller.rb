class SearchTermsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_search_term, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @new_term = SearchTerm.new
    @search_terms = SearchTerm.all
    if current_user.email == "cameronjkidman@gmail.com"
      respond_with(@search_terms)
    else
      redirect_to new_search_term_path
    end
  end

  def show
    respond_with(@search_term)
  end

  def new
    @search_term = SearchTerm.new
    respond_with(@search_term)
  end

  def cancel
    @search_term = SearchTerm.find_by_id(params[:search_term_id])
    @search_term.cancel_term
    flash[:success] = "That term was canceled!"
    redirect_to user_dashboard_path
  end

  def edit
  end

  def create
    carryover = search_term_params
    # create the RSS URL here
    # @search_term.rss_url = @search_term.ksl_query_string(@search_term.term)

    # if @search_term.save
    #   @search_term.create_feed(serialized_feedjira: YAML::dump(Feedjira::Feed.fetch_and_parse(@search_term.ksl_query_string(@search_term.rss_url))))
    #   redirect_to search_terms_path
    # end
    redirect_to new_charge_path(carryover)
  end

  def update
    @search_term.update(search_term_params)
    respond_with(@search_term)
  end

  def destroy
    @search_term.destroy
    respond_with(@search_term)
  end

  private
    def set_search_term
      @search_term = SearchTerm.find(params[:id])
    end

    def search_term_params
      params.require(:search_term).permit(:rss_url, :term => [])
    end
end
