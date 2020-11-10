class Request < ApplicationRecord
  has_many :signatures
  has_many :user_requests
  has_many :users, through: :user_requests
  


  # require 'origami'
  
  # include Origami


  self.per_page = 10

  validates_presence_of :document, user_ids:[]

  has_attached_file :document
  
  validates_attachment_content_type :document, :content_type => ["application/pdf"], 
     :path => ":attachment/:dod_id/:id/:style.:extension"

    
  def self.sign_pdf(request, current_user)
    @request = self.find(request)
    
    @user_request = UserRequest.find_by(user_id: current_user.id, request_id: request)
    @user_request.update(signed: true)
    
    @user_requests = UserRequest.where(request_id: request)
    
      if @user_requests.all?{|ur| ur.signed == true} 
        @request.update(status: "Aprovada")
      else
        @request.update(status: "Pendente")
      end
   
    # @OUTPUT_FILE = "#{File.basename(@request.document_file_name, ".rb")}.pdf"
    
    # key = OpenSSL::PKey::RSA.new 2048

    # cert = OpenSSL::X509::Certificate.new
    # cert.version = 2
    # cert.serial = 0
    # cert.not_before = Time.now
    # cert.not_after = Time.now + 3600

    # cert.public_key = key.public_key

    # cert.sign key, OpenSSL::Digest::SHA256.new

    # # Create the PDF contents
    # contents = Origami::ContentStream.new.setFilter(:FlateDecode)
    # contents.write @OUTPUT_FILE,
    # x: 350, y: 750, rendering: Text::Rendering::STROKE, size: 30

    # pdf = PDF.new
    # page = Page.new.setContents(contents)
    # pdf.append_page(page)

    # sig_annot = Annotation::Widget::Signature.new
    # sig_annot.Rect = Rectangle[llx: 89.0, lly: 386.0, urx: 190.0, ury: 353.0]

    # page.add_annotation(sig_annot)

    # # Sign the PDF with the specified keys
    # pdf.sign(cert, key,
    # method: 'adbe.pkcs7.detached',
    # annotation: sig_annot,
    # location: "Brazil",
    # contact: "contact@email",
    # reason: "Signature sample"
    # )

    # # Save the resulting file
    # pdf.save(@OUTPUT_FILE)

    # puts "PDF file saved as #{@OUTPUT_FILE}."

  end
end
