
'''
It is a bit unclear what this function should do yet. We have several options:

1. We use an off-the-shelf handpose or handposition estimator similar as for the headpose. We should test a couple if
we can find any and check their quality. If it is good enough, that would be great

2. We try to implement such an estimator ourselves. This would probably be too much work though and require additional
annotaion of the data.

3. Use a croped image of the steering wheel and its vicinity. Try to do classification based only on that image.
Hopefully we could distinguish at least a few classes from this. Just try to train for example a Random Forrest for that.
'''
def handpose_estimator(images):
    return None