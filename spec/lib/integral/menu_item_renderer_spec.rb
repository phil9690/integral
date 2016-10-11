require "rails_helper"

module Integral
  describe MenuItemRenderer do
    let(:menu_item_child) { create(:integral_menu_item_link, url: '/sub-menu-item-path', title: 'Sub Menu Item') }
    let(:menu_item_no_child) { create(:integral_menu_item_link, url: '/first-path', title: 'First Menu Item', html_classes: 'foo bar') }
    let(:menu_item_with_child) { create(:integral_menu_item_link, url: '/sub-menu-path', title: 'Sub Menu', children: [menu_item_child]) }
    let(:rendered_item_no_child) { "
      <li class=\"foo bar\"><a href=\"/first-path\">First Menu Item</a></li>
    ".strip }
    let(:rendered_item_with_child) { "
      <li><a href=\"/sub-menu-path\">Sub Menu</a>
        <ul>
          <li><a href=\"/sub-menu-item-path\">Sub Menu Item</a></li>
        </ul>
      </li>
    ".strip.gsub(/\n\s+/, "") }

    describe '#render' do
      it 'renders menu item' do
        expect(described_class.render(menu_item_no_child)).to eq rendered_item_no_child
      end

      context 'when menu item contains children' do
        it 'renders menu item and children' do
          expect(described_class.render(menu_item_with_child)).to eq rendered_item_with_child
        end
      end
    end

    let(:menu_item) { create(:integral_menu_item_basic) }
    let(:post) { create(:integral_post) }
    let(:menu_item_object) { create(:integral_menu_item_object, object_id: post.id, object_type: 0) }
    let(:menu_item_object_with_override) { create(:integral_menu_item_object, object_id: post.id, object_type: 0, title: 'Overide Title') }

    subject { described_class.new(menu_item) }

    # TODO: Test all different attrs
    describe '#title' do
      context 'when an object is linked' do
        subject { described_class.new(menu_item_object) }

        it 'returns the title of the object' do
          expect(subject.title).to eq post.title
        end

        context 'when override is given' do
          subject { described_class.new(menu_item_object_with_override) }

          it 'returns overriden title' do
            expect(subject.title).to eq subject.menu_item.title
          end
        end
      end

      it 'returns correct title' do
        expect(subject.title).to eq subject.menu_item.title
      end
    end
  end
end
