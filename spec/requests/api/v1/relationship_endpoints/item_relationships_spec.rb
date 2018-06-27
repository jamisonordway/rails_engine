describe 'items API' do
    describe 'relationships' do
      xit "can return all items associated with a item" do
        create(:item)
        id = Item.last.id
        id_2 = 2
  
        create(:item, id: id_2)
        create_list(:item, 5, item_id: id)
        create_list(:item, 9, item_id: id_2)
        
        get "/api/v1/items/#{id}/items"
  
        items = JSON.parse(response.body)
        
        expect(response).to be_successful
        expect(items.count).to eq(5)
      end
      xit "can return all invoices associated with a item" do
        create(:item)
        id = Item.last.id
        id_2 = 2
  
        create(:item, id: id_2)
        create_list(:invoice, 4, item_id: id)
        create_list(:invoice, 8, item_id: id_2)
  
        
        get "/api/v1/items/#{id}/invoices"
        invoices = JSON.parse(response.body)
  
        expect(response).to be_successful
        expect(invoices.count).to eq(4)
        end 
      end
    end 