require 'rails_helper'

module Integral
  describe ApplicationHelper, type: :helper do
    describe '#render_flashes' do
      let(:flash) { { notice: 'Foo notice message',
        alert: 'Foo alert message',
        error: 'Foo error message'
      } }
      let(:expected_markup) { "<div id=\"flash_list\">#{notice_markup}#{alert_markup}#{error_markup}</div>" }
      let(:notice_markup) { "<div class=\"flash\" data-message=\"Foo notice message\" data-klass=\"notice\"></div>" }
      let(:alert_markup) { "<div class=\"flash\" data-message=\"Foo alert message\" data-klass=\"alert\"></div>" }
      let(:error_markup) { "<div class=\"flash\" data-message=\"Foo error message\" data-klass=\"error\"></div>" }

      before { allow(helper).to receive(:flash).and_return(flash) }

      it 'renders out the correct markup' do
        expect(helper.render_flashes).to eq(expected_markup)
      end
    end
  end
end
