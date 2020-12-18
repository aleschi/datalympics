class DocumentsController < ApplicationController
  before_action :set_document, only: [:update, :destroy]
  before_action :authenticate_user!
  def new
    @document = Document.new
  end 
  
  def create
     @document = Document.new(document_params)
    respond_to do |format|
      if @document.save
        format.html { redirect_to documents_etat_path }
      else
        format.html { render :new }
      end
    end
  end 
  
  def edit
    @document= Document.find(params[:id])
    
    respond_to :js 
  end 
  
  def update
    respond_to do |format|
      if @document.update(document_params)
        format.html { redirect_to documents_etat_path }
      else
        format.html { render :edit }
      end
    end
  end 
  
  def destroy
    @document.destroy
    
    respond_to :js 
  end
  
  def delete_file 
    @document = Document.find(params[:id])
    @document.file.purge
    redirect_to documents_etat_path
  end 
  
  def documents_etat
     @nav=true
    @document= Document.where('appartenance = ?', "etat").first
    @documents= Document.where('appartenance = ?', "etat")
    
    @dates = [2025,2024,2023,2022,2021,2020,2019,2018]
  end
  
  def documents_solideo
     @nav=true
    @documents= Document.where('appartenance = ?', "solideo")
  end
 
  
    private
    # Use callbacks to share common setup or constraints between actions.
    def set_document
      @document = Document.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def document_params
      params.require(:document).permit(:name,:appartenance, :extension, :date, :file)
    end
end