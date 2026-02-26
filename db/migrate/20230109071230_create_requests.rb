class CreateRequests < ActiveRecord::Migration[8.0]
  def adapter
    @adapter ||= ActiveRecord::Base.connection.adapter_name.downcase.then { ActiveSupport::StringInquirer.new _1 }
  end

  def change
    methods = %w[get post put patch delete head options trace connect]
    states  = %w[received queued sending responded failed]

    unless adapter.sqlite?
      create_enum :http_method, methods
      create_enum :request_state, states
    end

    create_table :responses do |t|
      t.string  :type, null: false
      t.integer :status, null: false

      t.jsonb :headers
      t.text :body

      t.timestamps

      t.check_constraint %(status BETWEEN 0 AND 999), name: "valid_status"
    end

    create_table :requests do |t|
      t.string :type, null: false, index: true
      t.string :state, null: false
      t.string :http_method, null: false
      t.string :root, null: false, index: true
      t.string :path, null: false, index: true

      t.jsonb :params
      t.jsonb :headers
      t.text :body

      t.references :response, foreign_key: true

      t.timestamps

      t.check_constraint %{http_method in (#{methods.map { "'#{_1}'" }.join(?,)})}, name: "http_method_enum"
      t.check_constraint %{state in (#{states.map { "'#{_1}'" }.join(?,)})}, name: "state_enum"
    end

    add_index :requests, %i[type path params http_method]
  end
end
