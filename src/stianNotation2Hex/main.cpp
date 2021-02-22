#include <iostream>
#include <fstream>
#include <iomanip>
#include <sstream>

void printUsage()
{
	std::cout << "Usage: music [file]" << std::endl;
}

int main(int argc, char** argv)
{
	std::string fileName;
	if (argc != 2)
	{
		printUsage();
		return 1;
	}

	const std::string argument = argv[1];

	if (argument == "-h" || argument == "--help")
	{
		printUsage();
		return 1;
	}

	std::fstream fileStream;
	std::string output = "echo -e '";

	fileStream.open(argument);

	if (fileStream.fail())
	{
		std::cout << "No such file exists." << std::endl;
		printUsage();
		return 1;
	}

	int repeatNumber;

	while (fileStream >> repeatNumber)
	{
		char character;
		fileStream >> character;

		for (int i = 0; i < repeatNumber; i++)
		{
			std::stringstream stream;
			stream << std::hex << (int)character;
			output += "\\x";
			output += stream.str();
		}
	}

	output += "' < /dev/ttyUSB1";

	std::cout << output << std::endl;

	fileStream.close();
	return 0;
}
