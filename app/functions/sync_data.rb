class SyncData

  def self.activate

    if Shop.first
      shop = Shop.first
    else
      shop = Shop.new
    end

    if Collection.first
      collection = Collection.first
    else
      collection = Collection.new
    end

    shopify_shop = ShopifyAPI::Shop.current
    shopify_collection = ShopifyAPI::SmartCollection.find 402995017

    shop.name = shopify_shop.name
    shop.url = shopify_shop.domain
    shop.currency = shopify_shop.currency

    if shop.save
      puts Colorize.green "shop saved"
    else
      puts Colorize.red "error saving shop"
    end

    collection.title = shopify_collection.title
    collection.description = shopify_collection.body_html

    if collection.save
      puts Colorize.green "collection saved"
    else
      puts Colorize.red "error saving collection"
    end

    pages = (shopify_collection.products_count  / 250.0).ceil

    for page in 1..pages
      for shopify_product in ShopifyAPI::Product.find(:all, params: {limit: 250, page: page, collection_id: shopify_collection.id})
        metafields = shopify_product.metafields

        if Product.where(shopify_id: shopify_product.id).present?
          product = Product.where(shopify_id: shopify_product.id).first
        else
          product = Product.new
        end

        product.shopify_id = shopify_product.id
        product.title = shopify_product.title
        product.description = shopify_product.body_html
        product.vendor = shopify_product.vendor
        product.tags = shopify_product.tags ? shopify_product.tags : ''
        product.shopify_type = shopify_product.product_type
        product.options = shopify_product.options.map{|o| o.name}
        product.featured_image = shopify_product.images.first&.src

        product.title_tag = metafields.select{|m| m.namespace == "global" && m.key == "title_tag"}.first&.value
        product.description_tag = metafields.select{|m| m.namespace == "global" && m.key == "description_tag"}.first&.value

        product.google_product_type = metafields.select{|m| m.namespace == "google" && m.key == "google_product_type"}.first&.value
        product.age_group = metafields.select{|m| m.namespace == "google" && m.key == "age_group"}.first&.value

        product.custom_label_0 = metafields.select{|m| m.namespace == "google" && m.key == "custom_label_0"}.first&.value
        product.custom_label_1 = metafields.select{|m| m.namespace == "google" && m.key == "custom_label_1"}.first&.value
        product.custom_label_2 = metafields.select{|m| m.namespace == "google" && m.key == "custom_label_2"}.first&.value
        product.custom_label_3 = metafields.select{|m| m.namespace == "google" && m.key == "custom_label_3"}.first&.value
        product.custom_label_4 = metafields.select{|m| m.namespace == "google" && m.key == "custom_label_4"}.first&.value

        product.collection_id = collection.id

        if product.save
          puts Colorize.green "#{product.title} saved"

          for shopify_variant in shopify_product.variants

            if Variant.where(shopify_id: shopify_variant.id).present?
              variant = Variant.where(shopify_id: shopify_variant.id).first
            else
              variant = Variant.new
            end

            variant_options = []
            if shopify_variant.option1
              variant_options << shopify_variant.option1
            end
            if shopify_variant.option2
              variant_options << shopify_variant.option2
            end
            if shopify_variant.option3
              variant_options << shopify_variant.option3
            end

            variant.shopify_id = shopify_variant.id
            variant.url = '/products/' + shopify_product.handle + '?variant=' + shopify_variant.id.to_s
            variant.options = variant_options
            variant.price = shopify_variant.price
            variant.available = shopify_variant.inventory_policy == "continue" or shopify_variant.inventory_quantity > 0
            variant.image_src = shopify_product.images.select{|i| i.id == shopify_variant.image_id}.first&.src
            variant.barcode = shopify_variant.barcode
            variant.sku = shopify_variant.sku
            variant.weight = shopify_variant.weight
            variant.weight_unit = shopify_variant.weight_unit

            variant.product_id = product.id

            if variant.save
              puts Colorize.green "#{variant.url} saved"
            else
              puts Colorize.red "#{variant.url} error"
            end

          end
        else
          puts Colorize.red "#{product.title} error"
        end
      end
    end

  end

end