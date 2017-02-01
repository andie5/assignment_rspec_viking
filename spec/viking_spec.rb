# /spec/viking_spec.rb
require 'viking'

describe Viking do

  before do
     allow(STDOUT).to receive(:puts).and_return(nil)
  end

  let(:viking){Viking.new("Paul", 300, 30)}
  let(:thor){Viking.new("Thor",90, 10, Bow.new)}
  let(:bow){Bow.new}
  let(:axe){Axe.new}

  describe '#initialize' do
    it "Passing a name to a new Viking sets that name attribute" do
      expect(viking.name).to eq("Paul")
    end

    it 'Passing a health attribute to a new Viking sets that health attribute' do
      expect(viking.health).to eq(300)
    end

    it "health cannot be overwritten after it\'s been set on initialize" do
      expect{viking.health = 900}.to raise_error(NoMethodError)
    end

    it "A Viking\'s weapon starts out nil by default" do
      expect(viking.weapon).to eq(nil)
    end
  end

  describe "Viking weapons" do
    it "Picking up a Weapon sets it as the Viking\'s weapon" do
      expect(viking.pick_up_weapon(bow)).to eq(viking.weapon)
    end

    it "Picking up a non-Weapon raises an exception:" do
      expect{viking.pick_up_weapon(viking)}.to raise_error("Can't pick up that thing")
    end

    it "Picking up a new Weapon replaces the Viking's existing weapon" do
      viking.pick_up_weapon(bow)
      viking.pick_up_weapon(axe)
      expect(viking.weapon).to be_a(Axe)
    end

    it "Dropping a Viking's weapon leaves the Viking weaponless" do
      tina = Viking.new("Tina", 10, 30, Bow.new)
      tina.drop_weapon
      expect(tina.weapon).to be_nil
    end
  end

  describe "#receive_attack" do
    it "The receive_attack method reduces that Viking's health by the specified amount" do
      viking.receive_attack(10)
      expect(viking.health).to eq(290)
    end

    it "The receive_attack method calls the take_damage method (hint: recall expect(...).to receive(...))" do
      expect(viking).to receive(:take_damage)
      viking.receive_attack(2)
    end
  end

  describe "#attack" do
    it "attacking another Viking causes the recipient's health to drop" do
      liam = Viking.new("Liam",200, 10, Bow.new)
      viking.attack(liam)
      expect(liam.health).to be <(200)
    end

    it "attacking another Viking calls that Viking's take_damage method" do
      kerry = Viking.new("Kerry",100, 10, Bow.new)
      expect(kerry).to receive(:take_damage)
      viking.attack(kerry)
    end

    it "attacking with no weapon runs damage_with_fists" do
      viking_fist = Viking.new("Viking_Fist")
      expect(viking_fist).to receive(:damage_with_fists).and_return(7.5)
      viking_fist.attack(thor)
    end

    it "attacking with no weapon deals Fists multiplier times strength damage" do
      strength = 40
      multiplier = 0.25
      damage = strength * multiplier
      ian = Viking.new("Ian", 100, strength)

      expect(ian).to receive(:damage_with_fists).and_return(damage)
      ian.attack(thor)
    end

    it "attacking with a weapon runs damage_with_weapon" do
      expect(thor).to receive(:damage_with_weapon).and_return(20)
      thor.attack(viking)
    end

    it "attacking with a weapon deals damage equal to the Viking's strength times that Weapon's multiplier" do
      strength = 10
      multiplier = 2
      damage = strength * multiplier
      expect(thor).to receive(:damage_with_weapon).and_return(damage)
      thor.attack(viking)
    end

    it "attacking using a Bow without enough arrows uses Fists instead" do
      oleg = Viking.new("Oleg", 50, 10, Bow.new(0))
      expect(oleg).to receive(:damage_with_fists).and_return(2.5)
      oleg.attack(thor)
    end

    it "Killing a Viking raises an error" do
      weak_viking = Viking.new("Weak_Viking", 1,10)
      expect{viking.attack(weak_viking)}.to raise_error("Weak_Viking has Died...")
    end
  end
end
