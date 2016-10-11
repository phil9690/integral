require "rails_helper"

module Integral
  describe MenuRenderer do
    let(:rendered_menu_item) { "<li>Some List Item!</li>" }
    let(:rendered_menu) { "<ul id=\"awesome-menu\" class=\"foo bar\">#{rendered_menu_item}</ul>" }
    let(:menu) { create(:integral_menu, html_classes: 'foo bar', html_id: 'awesome-menu', menu_items: [create(:integral_menu_item_link)]) }

    before do
      allow(MenuItemRenderer).to receive(:render).and_return(rendered_menu_item)
    end

    describe '#render' do
      it 'returns rendered menu' do
        expect(described_class.render(menu)).to eq rendered_menu
      end
    end
  end
end
