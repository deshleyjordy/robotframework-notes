import random
import string

__version__ = '1.0.0'


class CustomLibrary(object):
    ROBOT_LIBRARY_VERSION = __version__
    ROBOT_LIBRARY_SCOPE = 'GLOBAL'

    def get_random_name(self, email_length):
        letters = string.ascii_lowercase[:12]
        return ''.join(random.choice(letters) for i in range(email_length))

    def generate_random_emails(self, length):

        domains = ["hotmail.com", "gmail.com", "aol.com",
                   "mail.com", "mail.kz", "yahoo.com"]

        return [self.get_random_name(length)
                + '@'
                + random.choice(domains)]
    
    # Creating an own Python function to generate a full name    
    def generate_random_name(self):
        first_names = ['John', 'Alice', 'Michael', 'Emma', 'David', 'Olivia']
        last_names = ['Smith', 'Johnson', 'Brown', 'Lee', 'Garcia', 'Davis']

        first_name = random.choice(first_names)
        last_name = random.choice(last_names)

        full_name = f"{first_name} {last_name}"
        return full_name
