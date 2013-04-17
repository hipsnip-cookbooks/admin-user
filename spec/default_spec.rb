require_relative 'spec_helper'


describe "admin-user::default" do
  context 'with the default attributes' do
    let(:chef_run) { ChefSpec::ChefRunner.new(CHEF_RUN_OPTIONS).converge('admin-user::default') }

    before(:each) do
      Chef::Recipe.any_instance.stub(:data_bag_item).and_return(Hash.new)
      Chef::Recipe.any_instance.stub(:data_bag_item).with("users", "admin").and_return({
        "id" => "admin",
        "authorized_keys" => {
          "default" => "ssh-rsa DDDDB3NzaC1yc4EDDDDBIwDDDQED2MXYaKVT5w66G2wzKRiJ6h4MjtbWkkhiYpjxTX6Jk6DdNU5NBNOI9zo5F04YdoCKtoRDdLM+VV/cDkbi4lqAbg7uCN/XBmdNNRcNCZUeoVj0LYzoHZp7+WGa/9bCOXBaQp0FFW23Kp3QYrQ+GeIaN9gn1D/q/FRxp9h+U2w9se7WZcqJCqijBVfiyjCEOPMbcd+Flgg2E4s8Afa5Q6tk3JcXSPIbl2eToOZz0KjtchqYj+mD1VRZDF2DPY73sUqsVIIx9ngNNryfrFqtdHZEeOQVW7Z6B1aYDmTYOfrSW1NtuJ2ZKhsgdVsbi9VO76U3kLmyE+XnXeDtUXip/chRUw== admin@mymachine.local"
        }
      })
    end

    it { chef_run.should create_user('admin') }
    it do
      chef_run.should create_file_with_content('/home/admin/.ssh/authorized_keys', "ssh-rsa DDDDB3NzaC1yc4EDDDDBIwDDDQED2MXYaKVT5w66G2wzKRiJ6h4MjtbWkkhiYpjxTX6Jk6DdNU5NBNOI9zo5F04YdoCKtoRDdLM+VV/cDkbi4lqAbg7uCN/XBmdNNRcNCZUeoVj0LYzoHZp7+WGa/9bCOXBaQp0FFW23Kp3QYrQ+GeIaN9gn1D/q/FRxp9h+U2w9se7WZcqJCqijBVfiyjCEOPMbcd+Flgg2E4s8Afa5Q6tk3JcXSPIbl2eToOZz0KjtchqYj+mD1VRZDF2DPY73sUqsVIIx9ngNNryfrFqtdHZEeOQVW7Z6B1aYDmTYOfrSW1NtuJ2ZKhsgdVsbi9VO76U3kLmyE+XnXeDtUXip/chRUw== admin@mymachine.local")
    end
  end

  context 'with multiple keys in the data bag' do
    context 'and all of them enabled' do
      let(:chef_run) { ChefSpec::ChefRunner.new(CHEF_RUN_OPTIONS).converge('admin-user::default') }

      before(:each) do
        Chef::Recipe.any_instance.stub(:data_bag_item).and_return(Hash.new)
        Chef::Recipe.any_instance.stub(:data_bag_item).with("users", "admin").and_return({
          "id" => "admin",
          "authorized_keys" => {
            "john" => "ssh-rsa DDDDB3NzaC1yc4EDDDDBIwDDDQED2MXYaKVT5w66G2wzKRiJ6h4MjtbWkkhiYpjxTX6Jk6DdNU5NBNOI9zo5F04YdoCKtoRDdLM+VV/cDkbi4lqAbg7uCN/XBmdNNRcNCZUeoVj0LYzoHZp7+WGa/9bCOXBaQp0FFW23Kp3QYrQ+GeIaN9gn1D/q/FRxp9h+U2w9se7WZcqJCqijBVfiyjCEOPMbcd+Flgg2E4s8Afa5Q6tk3JcXSPIbl2eToOZz0KjtchqYj+mD1VRZDF2DPY73sUqsVIIx9ngNNryfrFqtdHZEeOQVW7Z6B1aYDmTYOfrSW1NtuJ2ZKhsgdVsbi9VO76U3kLmyE+XnXeDtUXip/chRUw== john@mymachine.local",
            "julie" => "ssh-rsa DDDDB4NzaC1yc4EDDDDBIwDDDQED2MXYaKVT5w66G2wzKRiJ6h4MjtbWkkhiYpjxTX6Jk6DdNU5NBNOI9zo5F04YdoCKtoRDdLM+VV/cDkbi4lqAbg7uCN/XBmdNNRcNCZUeoVj0LYzoHZp7+WGa/9bCOXBaQp0FFW23Kp3QYrQ+GeIaN9gn1D/q/FRxp9h+U2w9se7WZcqJCqijBVfiyjCEOPMbcd+Flgg2E4s8Afa5Q6tk3JcXSPIbl2eToOZz0KjtchqYj+mD1VRZDF2DPY73sUqsVIIx9ngNNryfrFqtdHZEeOQVW7Z6B1aYDmTYOfrSW1NtuJ2ZKhsgdVsbi9VO76U3kLmyE+XnXeDtUXip/chRUw== julie@mymachine.local",
            "jack" => "ssh-rsa DDDDB5NzaC1yc4EDDDDBIwDDDQED2MXYaKVT5w66G2wzKRiJ6h4MjtbWkkhiYpjxTX6Jk6DdNU5NBNOI9zo5F04YdoCKtoRDdLM+VV/cDkbi4lqAbg7uCN/XBmdNNRcNCZUeoVj0LYzoHZp7+WGa/9bCOXBaQp0FFW23Kp3QYrQ+GeIaN9gn1D/q/FRxp9h+U2w9se7WZcqJCqijBVfiyjCEOPMbcd+Flgg2E4s8Afa5Q6tk3JcXSPIbl2eToOZz0KjtchqYj+mD1VRZDF2DPY73sUqsVIIx9ngNNryfrFqtdHZEeOQVW7Z6B1aYDmTYOfrSW1NtuJ2ZKhsgdVsbi9VO76U3kLmyE+XnXeDtUXip/chRUw== jack@mymachine.local"
          }
        })
      end

      it { chef_run.should create_user('admin') }
      it do
        chef_run.should create_file_with_content('/home/admin/.ssh/authorized_keys', "ssh-rsa DDDDB3NzaC1yc4EDDDDBIwDDDQED2MXYaKVT5w66G2wzKRiJ6h4MjtbWkkhiYpjxTX6Jk6DdNU5NBNOI9zo5F04YdoCKtoRDdLM+VV/cDkbi4lqAbg7uCN/XBmdNNRcNCZUeoVj0LYzoHZp7+WGa/9bCOXBaQp0FFW23Kp3QYrQ+GeIaN9gn1D/q/FRxp9h+U2w9se7WZcqJCqijBVfiyjCEOPMbcd+Flgg2E4s8Afa5Q6tk3JcXSPIbl2eToOZz0KjtchqYj+mD1VRZDF2DPY73sUqsVIIx9ngNNryfrFqtdHZEeOQVW7Z6B1aYDmTYOfrSW1NtuJ2ZKhsgdVsbi9VO76U3kLmyE+XnXeDtUXip/chRUw== john@mymachine.local")
        chef_run.should create_file_with_content('/home/admin/.ssh/authorized_keys', "ssh-rsa DDDDB4NzaC1yc4EDDDDBIwDDDQED2MXYaKVT5w66G2wzKRiJ6h4MjtbWkkhiYpjxTX6Jk6DdNU5NBNOI9zo5F04YdoCKtoRDdLM+VV/cDkbi4lqAbg7uCN/XBmdNNRcNCZUeoVj0LYzoHZp7+WGa/9bCOXBaQp0FFW23Kp3QYrQ+GeIaN9gn1D/q/FRxp9h+U2w9se7WZcqJCqijBVfiyjCEOPMbcd+Flgg2E4s8Afa5Q6tk3JcXSPIbl2eToOZz0KjtchqYj+mD1VRZDF2DPY73sUqsVIIx9ngNNryfrFqtdHZEeOQVW7Z6B1aYDmTYOfrSW1NtuJ2ZKhsgdVsbi9VO76U3kLmyE+XnXeDtUXip/chRUw== julie@mymachine.local")
        chef_run.should create_file_with_content('/home/admin/.ssh/authorized_keys', "ssh-rsa DDDDB5NzaC1yc4EDDDDBIwDDDQED2MXYaKVT5w66G2wzKRiJ6h4MjtbWkkhiYpjxTX6Jk6DdNU5NBNOI9zo5F04YdoCKtoRDdLM+VV/cDkbi4lqAbg7uCN/XBmdNNRcNCZUeoVj0LYzoHZp7+WGa/9bCOXBaQp0FFW23Kp3QYrQ+GeIaN9gn1D/q/FRxp9h+U2w9se7WZcqJCqijBVfiyjCEOPMbcd+Flgg2E4s8Afa5Q6tk3JcXSPIbl2eToOZz0KjtchqYj+mD1VRZDF2DPY73sUqsVIIx9ngNNryfrFqtdHZEeOQVW7Z6B1aYDmTYOfrSW1NtuJ2ZKhsgdVsbi9VO76U3kLmyE+XnXeDtUXip/chRUw== jack@mymachine.local")
      end
    end


    context 'and only some of them enabled' do
      let(:chef_run) do
        ChefSpec::ChefRunner.new(CHEF_RUN_OPTIONS) { |node|
          node.set['admin-user']['authorized_keys'] = [ 'john', 'jack' ]
        }.converge('admin-user::default')
      end

      before(:each) do
        Chef::Recipe.any_instance.stub(:data_bag_item).and_return(Hash.new)
        Chef::Recipe.any_instance.stub(:data_bag_item).with("users", "admin").and_return({
          "id" => "admin",
          "authorized_keys" => {
            "john" => "ssh-rsa DDDDB3NzaC1yc4EDDDDBIwDDDQED2MXYaKVT5w66G2wzKRiJ6h4MjtbWkkhiYpjxTX6Jk6DdNU5NBNOI9zo5F04YdoCKtoRDdLM+VV/cDkbi4lqAbg7uCN/XBmdNNRcNCZUeoVj0LYzoHZp7+WGa/9bCOXBaQp0FFW23Kp3QYrQ+GeIaN9gn1D/q/FRxp9h+U2w9se7WZcqJCqijBVfiyjCEOPMbcd+Flgg2E4s8Afa5Q6tk3JcXSPIbl2eToOZz0KjtchqYj+mD1VRZDF2DPY73sUqsVIIx9ngNNryfrFqtdHZEeOQVW7Z6B1aYDmTYOfrSW1NtuJ2ZKhsgdVsbi9VO76U3kLmyE+XnXeDtUXip/chRUw== john@mymachine.local",
            "julie" => "ssh-rsa DDDDB4NzaC1yc4EDDDDBIwDDDQED2MXYaKVT5w66G2wzKRiJ6h4MjtbWkkhiYpjxTX6Jk6DdNU5NBNOI9zo5F04YdoCKtoRDdLM+VV/cDkbi4lqAbg7uCN/XBmdNNRcNCZUeoVj0LYzoHZp7+WGa/9bCOXBaQp0FFW23Kp3QYrQ+GeIaN9gn1D/q/FRxp9h+U2w9se7WZcqJCqijBVfiyjCEOPMbcd+Flgg2E4s8Afa5Q6tk3JcXSPIbl2eToOZz0KjtchqYj+mD1VRZDF2DPY73sUqsVIIx9ngNNryfrFqtdHZEeOQVW7Z6B1aYDmTYOfrSW1NtuJ2ZKhsgdVsbi9VO76U3kLmyE+XnXeDtUXip/chRUw== julie@mymachine.local",
            "jack" => "ssh-rsa DDDDB5NzaC1yc4EDDDDBIwDDDQED2MXYaKVT5w66G2wzKRiJ6h4MjtbWkkhiYpjxTX6Jk6DdNU5NBNOI9zo5F04YdoCKtoRDdLM+VV/cDkbi4lqAbg7uCN/XBmdNNRcNCZUeoVj0LYzoHZp7+WGa/9bCOXBaQp0FFW23Kp3QYrQ+GeIaN9gn1D/q/FRxp9h+U2w9se7WZcqJCqijBVfiyjCEOPMbcd+Flgg2E4s8Afa5Q6tk3JcXSPIbl2eToOZz0KjtchqYj+mD1VRZDF2DPY73sUqsVIIx9ngNNryfrFqtdHZEeOQVW7Z6B1aYDmTYOfrSW1NtuJ2ZKhsgdVsbi9VO76U3kLmyE+XnXeDtUXip/chRUw== jack@mymachine.local"
          }
        })
      end

      it { chef_run.should create_user('admin') }
      it do
        chef_run.should create_file_with_content('/home/admin/.ssh/authorized_keys', "ssh-rsa DDDDB3NzaC1yc4EDDDDBIwDDDQED2MXYaKVT5w66G2wzKRiJ6h4MjtbWkkhiYpjxTX6Jk6DdNU5NBNOI9zo5F04YdoCKtoRDdLM+VV/cDkbi4lqAbg7uCN/XBmdNNRcNCZUeoVj0LYzoHZp7+WGa/9bCOXBaQp0FFW23Kp3QYrQ+GeIaN9gn1D/q/FRxp9h+U2w9se7WZcqJCqijBVfiyjCEOPMbcd+Flgg2E4s8Afa5Q6tk3JcXSPIbl2eToOZz0KjtchqYj+mD1VRZDF2DPY73sUqsVIIx9ngNNryfrFqtdHZEeOQVW7Z6B1aYDmTYOfrSW1NtuJ2ZKhsgdVsbi9VO76U3kLmyE+XnXeDtUXip/chRUw== john@mymachine.local")
        chef_run.should create_file_with_content('/home/admin/.ssh/authorized_keys', "ssh-rsa DDDDB5NzaC1yc4EDDDDBIwDDDQED2MXYaKVT5w66G2wzKRiJ6h4MjtbWkkhiYpjxTX6Jk6DdNU5NBNOI9zo5F04YdoCKtoRDdLM+VV/cDkbi4lqAbg7uCN/XBmdNNRcNCZUeoVj0LYzoHZp7+WGa/9bCOXBaQp0FFW23Kp3QYrQ+GeIaN9gn1D/q/FRxp9h+U2w9se7WZcqJCqijBVfiyjCEOPMbcd+Flgg2E4s8Afa5Q6tk3JcXSPIbl2eToOZz0KjtchqYj+mD1VRZDF2DPY73sUqsVIIx9ngNNryfrFqtdHZEeOQVW7Z6B1aYDmTYOfrSW1NtuJ2ZKhsgdVsbi9VO76U3kLmyE+XnXeDtUXip/chRUw== jack@mymachine.local")
        chef_run.should_not create_file_with_content('/home/admin/.ssh/authorized_keys', "ssh-rsa DDDDB4NzaC1yc4EDDDDBIwDDDQED2MXYaKVT5w66G2wzKRiJ6h4MjtbWkkhiYpjxTX6Jk6DdNU5NBNOI9zo5F04YdoCKtoRDdLM+VV/cDkbi4lqAbg7uCN/XBmdNNRcNCZUeoVj0LYzoHZp7+WGa/9bCOXBaQp0FFW23Kp3QYrQ+GeIaN9gn1D/q/FRxp9h+U2w9se7WZcqJCqijBVfiyjCEOPMbcd+Flgg2E4s8Afa5Q6tk3JcXSPIbl2eToOZz0KjtchqYj+mD1VRZDF2DPY73sUqsVIIx9ngNNryfrFqtdHZEeOQVW7Z6B1aYDmTYOfrSW1NtuJ2ZKhsgdVsbi9VO76U3kLmyE+XnXeDtUXip/chRUw== julie@mymachine.local")
      end
    end
  end

  context 'with "overlord" as the user and group' do
    context 'and with "people" as the data_bag' do
      let(:chef_run) do
        ChefSpec::ChefRunner.new(CHEF_RUN_OPTIONS) { |node|
          node.set['admin-user']['user'] = "overlord"
          node.set['admin-user']['group'] = "overlord"
          node.set['admin-user']['data_bag'] = "people"
        }.converge('admin-user::default')
      end

      before(:each) do
        Chef::Recipe.any_instance.stub(:data_bag_item).and_return(Hash.new)
        Chef::Recipe.any_instance.stub(:data_bag_item).with("people", "overlord").and_return({
          "id" => "admin",
          "authorized_keys" => {
            "default" => "ssh-rsa DDDDB3NzaC1yc4EDDDDBIwDDDQED2MXYaKVT5w66G2wzKRiJ6h4MjtbWkkhiYpjxTX6Jk6DdNU5NBNOI9zo5F04YdoCKtoRDdLM+VV/cDkbi4lqAbg7uCN/XBmdNNRcNCZUeoVj0LYzoHZp7+WGa/9bCOXBaQp0FFW23Kp3QYrQ+GeIaN9gn1D/q/FRxp9h+U2w9se7WZcqJCqijBVfiyjCEOPMbcd+Flgg2E4s8Afa5Q6tk3JcXSPIbl2eToOZz0KjtchqYj+mD1VRZDF2DPY73sUqsVIIx9ngNNryfrFqtdHZEeOQVW7Z6B1aYDmTYOfrSW1NtuJ2ZKhsgdVsbi9VO76U3kLmyE+XnXeDtUXip/chRUw== overlord@mymachine.local"
          }
        })
      end

      it { chef_run.should create_user('overlord') }
      it do
        chef_run.should create_file_with_content('/home/overlord/.ssh/authorized_keys', "ssh-rsa DDDDB3NzaC1yc4EDDDDBIwDDDQED2MXYaKVT5w66G2wzKRiJ6h4MjtbWkkhiYpjxTX6Jk6DdNU5NBNOI9zo5F04YdoCKtoRDdLM+VV/cDkbi4lqAbg7uCN/XBmdNNRcNCZUeoVj0LYzoHZp7+WGa/9bCOXBaQp0FFW23Kp3QYrQ+GeIaN9gn1D/q/FRxp9h+U2w9se7WZcqJCqijBVfiyjCEOPMbcd+Flgg2E4s8Afa5Q6tk3JcXSPIbl2eToOZz0KjtchqYj+mD1VRZDF2DPY73sUqsVIIx9ngNNryfrFqtdHZEeOQVW7Z6B1aYDmTYOfrSW1NtuJ2ZKhsgdVsbi9VO76U3kLmyE+XnXeDtUXip/chRUw== overlord@mymachine.local")
      end
    end
  end
end