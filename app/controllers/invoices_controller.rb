class InvoicesController < ApplicationController
  def index
  end

  def show
  end

  def new
  end

  def create
  #   require 'faker'
  #   require 'net/ftp'
  #   ftp = Net::FTP.new("ftp.cluster021.hosting.ovh.net")
  # # run the script like
  # # ruby ftp.rb username password
  #   ftp.login("loxambasii", "gaUhVmu4qXth")
  #   ftp.chdir("/gcom_tmp")

  #   files_ord = ftp.nlst('*.ord')
  #   files_pdf = ftp.nlst('*.pdf')

  #   puts "File list obtained... #{files_ord}"
  #   puts "File list obtained... #{files_pdf}"

  #   files_ord.each do |fname|
  #     puts "Downloading file #{fname}"
  #     ftp.getbinaryfile(fname, fname)

  #     text = File.open(fname).read
  #     text.each_line do |line|
  #       array = line.strip.split(/\;/)

  #       unless User.where(loxam_id: array[2]).exists?
  #         User.create(company: array[3], email: Faker::Internet.email,
  #                   password: Faker::IDNumber.valid, loxam_id: array[2])
  #       end

  #       files_pdf.each do |pdf_doc|
  #         if pdf_doc == array[6]
  #         p "#{pdf_doc} == #{array[6]}"
  #           ftp.getbinaryfile(pdf_doc, pdf_doc)
  #           new_doc = Document.new(document_type: "fac", user_id: User.where(loxam_id: array[2]).take.id)
  #           new_doc.remote_pdf_url = pdf_doc
  #           new_doc.save
  #         end
  #       end
  #     end
  #     File.delete(fname)
  #     File.delete(pdf_doc)
  #   end
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
