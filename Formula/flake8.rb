class Flake8 < Formula
  include Language::Python::Virtualenv

  desc "Lint your Python code for style and logical errors"
  homepage "https://flake8.pycqa.org/"
  url "https://files.pythonhosted.org/packages/9e/47/15b267dfe7e03dca4c4c06e7eadbd55ef4dfd368b13a0bab36d708b14366/flake8-3.9.2.tar.gz"
  sha256 "07528381786f2a6237b061f6e96610a4167b226cb926e2aa2b6b1d78057c576b"
  license "MIT"
  revision 1
  head "https://gitlab.com/PyCQA/flake8.git"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "dc28f983cd59b56dfe54cfc2827e7f68263705cc385a014af8e09c478d75385c"
    sha256 cellar: :any_skip_relocation, big_sur:       "87a52580d472a517fa23a80cc27143c208ab53b2c301f7fdf65fe2ac2a725251"
    sha256 cellar: :any_skip_relocation, catalina:      "87a52580d472a517fa23a80cc27143c208ab53b2c301f7fdf65fe2ac2a725251"
    sha256 cellar: :any_skip_relocation, mojave:        "87a52580d472a517fa23a80cc27143c208ab53b2c301f7fdf65fe2ac2a725251"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9a2aacfe74639153bb6c2d2ab76af234212e06e97fec3e32c9d4dedf462c5127"
  end

  depends_on "python@3.10"

  resource "mccabe" do
    url "https://files.pythonhosted.org/packages/06/18/fa675aa501e11d6d6ca0ae73a101b2f3571a565e0f7d38e062eec18a91ee/mccabe-0.6.1.tar.gz"
    sha256 "dd8d182285a0fe56bace7f45b5e7d1a6ebcbf524e8f3bd87eb0f125271b8831f"
  end

  resource "pycodestyle" do
    url "https://files.pythonhosted.org/packages/02/b3/c832123f2699892c715fcdfebb1a8fdeffa11bb7b2350e46ecdd76b45a20/pycodestyle-2.7.0.tar.gz"
    sha256 "c389c1d06bf7904078ca03399a4816f974a1d590090fecea0c63ec26ebaf1cef"
  end

  resource "pyflakes" do
    url "https://files.pythonhosted.org/packages/a8/0f/0dc480da9162749bf629dca76570972dd9cce5bedc60196a3c912875c87d/pyflakes-2.3.1.tar.gz"
    sha256 "f5bc8ecabc05bb9d291eb5203d6810b49040f6ff446a756326104746cc00c1db"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    (testpath/"test-bad.py").write <<~EOS
      print ("Hello World!")
    EOS

    (testpath/"test-good.py").write <<~EOS
      print("Hello World!")
    EOS

    assert_match "E211", shell_output("#{bin}/flake8 test-bad.py", 1)
    assert_empty shell_output("#{bin}/flake8 test-good.py")
  end
end
