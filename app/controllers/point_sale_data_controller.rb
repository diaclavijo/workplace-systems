class PointSaleDataController < ApplicationController

  # GET /point_sale_data/1
  # GET /point_sale_data/1.json
  def show
    @point_sale_data = PointSaleDatum.all
  end

  # GET /point_sale_data/new
  def new
    # Receive the file -
    @point_sale_datum = PointSaleDatum.new
  end


  # POST /point_sale_data
  # POST /point_sale_data.json
  def create

    upload = SalesUploader.new
    upload.store! params['point_sale_datum']['file']
    FastestCSV.open('testSalesUpload10.csv') do |csv|
      csv.shift
      while values = csv.shift
        array = values.parse_csv
        PointSaleDatum.create!(datetime: Time.parse(array[0] + array[1]), code: array[2], value: array[3])
      end
    end


    respond_to do |format|
      if @point_sale_datum.save
        format.html { redirect_to @point_sale_datum, notice: 'Point sale datum was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_point_sale_datum
      @point_sale_datum = PointSaleDatum.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def point_sale_datum_params
      params.require(:point_sale_datum).permit(:file)
    end
end
