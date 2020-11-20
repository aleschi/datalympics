class DocumentsController < ApplicationController
  before_action :set_etat_depense, only: [:update, :destroy]
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
  def documents_etat
     @nav=true
    @document= Document.where('appartenance = ?', "etat").first
    @documents= Document.where('appartenance = ?', "etat")
  end
  
    private
    # Use callbacks to share common setup or constraints between actions.
    def set_document
      @document = Document.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def document_params
      params.require(:document).permit(:name,:appartenance, :extension, :file)
    end
end