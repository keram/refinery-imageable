require 'spec_helper'

module Refinery
  describe Page do
    it "can have images added" do
      page = FactoryGirl.create(:page)
      page.images.count.should eq(0)

      page.images << FactoryGirl.create(:image)
      page.images.count.should eq(1)
    end

    describe "add and delete images" do
      it "adds images" do
        page = FactoryGirl.create(:page)
        image = FactoryGirl.create(:image)

        page.images.count.should == 0
        page.update_attributes({
          imagenizations_attributes: { "0" => { image_id: image.id} }
        })

        page.images.count.should == 1
      end

      it "deletes specific images" do
        page = FactoryGirl.create(:page)
        image = FactoryGirl.create(:image)
        images = [image, image]
        page.images = images

        page.imagenizations.first.destroy
        page.images.reload

        page.images.should eq([image])
      end

      it "deletes all images" do
        page = FactoryGirl.create(:page)
        image = FactoryGirl.create(:image)
        images = [image, image]
        page.images = images

        page.imagenizations.destroy_all

        page.images.reload
        page.images.should be_empty
      end
    end
  end
end
