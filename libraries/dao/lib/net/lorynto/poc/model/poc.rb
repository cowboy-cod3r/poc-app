# Classpath
$:.unshift(File.join(File.dirname(__FILE__),'..','..','..','..'))

#
# Poc Model
# @author Sean Humbarger
class Poc
  # Libaries
  require 'net/lorynto/poc/dao/connection'

  # Modules
  include MongoMapper::Document

  # Force all operations to be 'safe' - such that mongo_mapper
  # waits for responses on CRUD operations
  safe

  # The keys pertaining to the model
  key :first_name,    String, :required => true
  key :middle_name,   String
  key :last_name,     String, :required => true
  key :created_by,    String

  # Upon insert, this will add an updated_at and created_at field date/time field
  timestamps!

  # Embedded Documents
  many :addresses
  many :phone_numbers
  many :emails

  #
  # Generate Indexes from the POC model
  def self.generate_indexes()
    self.ensure_index([
      [:first_name, 1],
      [:middle_name, 1],
      [:last_name, 1]
    ])
  end
end

#
# Address Model
# @author Sean Humbarger
class Address
  # Modules
  include MongoMapper::EmbeddedDocument

  # The keys pertaining to the model
  key  :type,     String, :required => true
  key  :street,   String, :required => true
  key  :city,     String, :required => true
  key  :state,    String, :required => true
  key  :zip_code, String, :required => true
end

#
# PhoneNumber Model
# @author Sean Humbarger
class PhoneNumber
  # Modules
  include MongoMapper::EmbeddedDocument

  # The keys pertaining to the model
  key :type,   String, :required => true
  key :number, String, :required => true
end

#
# Email Model
# @author Sean Humbarger
class Email
  # Modules
  include MongoMapper::EmbeddedDocument

  # The keys pertaining to the model
  key :type,   String, :required => true
  key :email,  String, :required => true
end