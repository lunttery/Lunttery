namespace :dev do
desc "重建一些假資料"
  task :build => ["tmp:clear", "log:clear", "db:drop", "db:create", "db:migrate"]
  task :rebuild => [:kill_postgres_connections, "dev:build", :fake]
  task :kill_postgres_connections => :environment do
    system "ps xa | grep postgres: | grep #{Rails.application.config_for(:database)["database"]} | awk '{print $1}' | xargs kill"
  end

  task :fake => :environment do
    user =  User.create(
              email: "test@gmail.com",
              password: "12345678",
              role: "admin",
              confirmed_at: Time.now
            )
    for shop_tag in 1..10 do
      @tag = Tag.create(name: "店家標籤#{shop_tag}", source_type: "Shop")
      puts "新增的店家標籤為: #{@tag.name}"
    end

    for meal_tag in 1..10 do
      @tag = Tag.create(name: "餐點標籤#{meal_tag}", source_type: "Meal")
      puts "新增的餐點標籤為: #{@tag.name}"
    end

    for shop in 1..50 do
      @shop = Shop.create(
                name: "店家#{shop}",
                address: "地址#{shop}",
                phone: "09#{Faker::Number.number(8)}",
                lng: Faker::Address.longitude.to_f,
                lat: Faker::Address.latitude.to_f,
                rate: (1..50).to_a.sample.to_f / 10,
                user_id: user.id,
                tag_ids: Tag.where(source_type: "Shop").pluck(:id).sample(rand(1..10))
              )
      puts "新增的店家名稱為: #{@shop.name}"

      for meal in 1..30 do
        @meal = Meal.create(
                  name: "餐點#{meal}",
                  price: (50..150).to_a.sample,
                  shop_id: @shop.id,
                  tag_ids: Tag.where(source_type: "Meal").pluck(:id).sample(rand(1..10))
                )
        puts "新增的餐點名稱為: #{@meal.name}"
      end
    end
  end
end
