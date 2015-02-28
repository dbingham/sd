source $SHPEC_ROOT/../sd

describe "sd"
  describe "adding a shift point"
    it "creates a symlink"
      sd add test_point &> /dev/null
      assert file_present $HOME/.sdd/test_point
      rm $HOME/.sdd/test_point
    end
  end

  describe "removing a shift point"
    it "removes a symlink"
      sd add test_point &> /dev/null
      sd rm test_point &> /dev/null
      assert file_absent $HOME/.sdd/test_point
    end
  end

  describe "shifting to a point"
    it "changes your working directory"
      cd /tmp
      sd add test_point &> /dev/null
      cd - &> /dev/null
      shifted_pwd="$(sd test_point && pwd)"
      rm $HOME/.sdd/test_point
      assert equal "$shifted_pwd" "/tmp"
    end

    it "changes to the previous working directory"
      expected_wd=$(pwd)
      cd /tmp && sd - &> /dev/null
      assert equal "$expected_wd" "$(pwd)"
    end
  end
end
