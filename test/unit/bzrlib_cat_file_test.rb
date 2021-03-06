require File.dirname(__FILE__) + '/../test_helper'

module Scm::Adapters
	class BzrlibCatFileTest < Scm::Test

		def test_cat_file
			with_bzrlib_repository('bzr') do |bzr|
				expected = <<-EXPECTED
first file
second line
EXPECTED
				assert_equal expected,
					bzr.cat_file(Scm::Commit::new(:token => 6),
						     Scm::Diff.new(:path => "file1.txt"))

				# file2.txt has been removed in commit #5
				assert_equal nil, bzr.cat_file(bzr.head,
							       Scm::Diff.new(:path => "file2.txt"))
			end
		end

		def test_cat_file_non_ascii_name
			with_bzrlib_repository('bzr') do |bzr|
				expected = <<-EXPECTED
first file
second line
EXPECTED
				assert_equal expected,
					bzr.cat_file(Scm::Commit::new(:token => 7),
						     Scm::Diff.new(:path => "Cédric.txt"))
			end
		end

		def test_cat_file_parent
			with_bzrlib_repository('bzr') do |bzr|
				expected = <<-EXPECTED
first file
second line
EXPECTED
				assert_equal expected,
					bzr.cat_file_parent(Scm::Commit::new(:token => 6),
							    Scm::Diff.new(:path => "file1.txt"))

				# file2.txt has been removed in commit #5
				expected = <<-EXPECTED
another file
EXPECTED
				assert_equal expected,
					bzr.cat_file_parent(Scm::Commit.new(:token => 5),
							    Scm::Diff.new(:path => "file2.txt"))
			end
		end

	end
end
