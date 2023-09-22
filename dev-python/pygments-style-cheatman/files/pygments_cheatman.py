from pygments.style import Style
from pygments.token import Comment

class CheatManStyle(Style):
	styles = {
		Comment: 'bold',
	}
