class QuotationsController < ApplicationController
  before_filter :authenticate_apparel_consultant!
  def index
    # @quotations = Quotation.all
    @quotations = Quotation.order('id DESC').page(params[:page]).per_page(10)
  end

  def new
    @quotation = Quotation.new
    @quotation.customer = Customer.new
    # @brand = Brand.all
    # @quotation.brand = Brand.new
    # @quotation.fit = Fit.new
    # @quotation.shirt_type = ShirtType.new

  end

  # def update_fits
  #   brand = Brand.find(params[:brand_id])
  #   fit = brand.fit
  #
  #   render :update do |page|
  #     page.replace_html 'quotation_fit_id', :partial => 'quotation_fit_id', :object => songs
  #   end
  # end
  def show
    @quotation = Quotation.find(params[:id])
  end

  def calculator
    @quotation= Quotation.new
  end

  def show_in_myr
    @quotation = Quotation.find(params[:id])
    Money.add_rate("SGD","MYR",@quotation.exchange_rate.to_f)
    render 'show_in_myr'
  end

  def show_price
    # @show_price = Quotation.new.showprice(params[:shirtid],params[:fitid],params[:methodid],params[:sizeid],params[:quantity],params[:noblock])
    shirt_price = 0
    front_price = 0
    back_price = 0
    right_price = 0
    left_price = 0
    @exchange_rate = ENV['CURRENCY']=='SGD' ? ConversionRate.last.exchange_rate : Money.new(100,"MYR")

    if(!(params[:shirt_type_id].blank?||params[:fit_id].blank?||params[:quantity].blank?))
      shirt_price = ShirtType.all.showprice(params[:shirt_type_id],params[:fit_id],params[:quantity])
    end

    if(!(params[:front_print_method_id].blank?||params[:front_block_size_id].blank?||params[:quantity].blank?))
      tempprice = PrintMethod.all.showprice(params[:front_print_method_id],params[:front_block_size_id],params[:quantity])
      tempblockcharge = PrintMethod.all.showblockcharge(params[:front_print_method_id],params[:front_block_size_id],params[:quantity])
      front_price = tempprice + tempblockcharge*params[:front_block_no].to_i
    end

    if(!(params[:back_print_method_id].blank?||params[:back_block_size_id].blank?||params[:quantity].blank?))
      tempprice = PrintMethod.all.showprice(params[:back_print_method_id],params[:back_block_size_id],params[:quantity])
      tempblockcharge = PrintMethod.all.showblockcharge(params[:back_print_method_id],params[:back_block_size_id],params[:quantity])
      back_price = tempprice + tempblockcharge*params[:back_block_no].to_i
    end

    if(!(params[:left_print_method_id].blank?||params[:quantity].blank?))
      tempprice = PrintMethod.all.showsleeveprice(params[:left_print_method_id],params[:quantity])
      tempblockcharge = PrintMethod.all.showsleeveblockcharge(params[:left_print_method_id],params[:quantity])
      left_price = tempprice + tempblockcharge*params[:left_block_no].to_i
    end

    if(!(params[:right_print_method_id].blank?||params[:quantity].blank?))
      tempprice = PrintMethod.all.showsleeveprice(params[:right_print_method_id],params[:quantity])
      tempblockcharge = PrintMethod.all.showsleeveblockcharge(params[:right_print_method_id],params[:quantity])
      right_price = tempprice + tempblockcharge*params[:right_block_no].to_i
    end

    special_print = Money.new(params[:special_print].to_i*100,"MYR")

    @show_price = shirt_price+front_price+back_price+left_price+right_price+special_print
    @show_cost = (shirt_price+front_price+back_price+left_price+right_price+special_print)*params[:quantity].to_i
    @show_min_rrp = @show_price-(@show_price/100)
    @show_max_rrp = @show_price+(@show_price/100)
  end

  def create
    @quotation = current_apparel_consultant.quotations.new(quotation_params)
    # respond_to do |format|
    #   format.html
    #   format.js{}
    #   format.json {
    #     render json: {quotation: @quotation}
    #   }
    # end
    if @quotation.save
      redirect_to @quotation
    else
      render 'new'
    # render :json => @quotation
    end
  end

  def edit
    @quotation = Quotation.find(params[:id])

  end

  def update
    @quotation = Quotation.find(params[:id])
    if @quotation.update(quotation_params)
      # redirect_to @quotation
      redirect_to @quotation
    else
      render 'edit'
    end
  end

  def destroy
    @quotation = Quotation.find(params[:id])
    @quotation.destroy

    redirect_to quotations_path
  end

  private
   def quotation_params
    #  ActionController::Parameters.permit_all_parameters = true
     params.require(:quotation).permit!
   end
end
