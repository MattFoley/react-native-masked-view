/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 */
'use strict';

import React from 'react-native';

let {
  AppRegistry,
  StyleSheet,
  Text,
  View,
  Image
} = React;

import MaskedView from 'MaskedView';

let gil = require('image!gil-portrait-small');

class MaskedViewDemo extends React.Component {

  constructor() {
    super();

    this.state = {
      shouldRenderImage : false,
    }
  }

  renderImageExample() {
    return (
      <View style={styles.container}>
        <Image source={gil}
               style={styles.imageContainer} />
        <MaskedView maskImage='hexagon.png'
                    style={styles.maskContainer}>
          <View style={styles.viewContainer}>
            <Text style={styles.welcome}>
              {'g@gilbox.me'}
            </Text>
            <Text style={styles.instructions}>
              {'Inside a MaskedView!'}
            </Text>
            <Text style={styles.instructions}>
              {'Note that the Mask stretches'}
            </Text>
            <Text style={styles.instructions}>
              {'to the size of the View'}
            </Text>
          </View>
        </MaskedView>
      </View>
    );
  }

  _renderOverlay() {
    if (this.state.viewToHighlight) {
      return (
        <MaskedView maskRefs={[this.state.viewToHighlight]}
                    maskCornerRadius={10}
                    style={styles.refMaskContainer}>
          <Image source={gil}/>
        </MaskedView>
      );
    } else {
      return false;
    }
  }

  _updateHighlightRef() {
    this.setState({
      viewToHighlight: React.findNodeHandle(this.nodeToHighlight),
    })
  }

  renderRefExample() {
    return (
      <View style={styles.refMaskContainer}>
        <View style={[styles.viewContainer,]}
              ref={(node) => {this.nodeToHighlight = node}}
              onLayout={this._updateHighlightRef.bind(this)}>
          <Text style={[styles.instructions, {paddingTop: 6,}]}>
            {'In this case'}
          </Text>
          <Text style={styles.instructions}>
            {'the mask is used to highlight'}
          </Text>
          <Text style={[styles.instructions,{paddingBottom: 6}]}>
            {'an element in siblings render tree.'}
          </Text>
        </View>
        {this._renderOverlay()}
      </View>
    )
  }

  render() {
    if (this.state.shouldRenderImage) {
      return this.renderImageExample();
    } else {
      return this.renderRefExample();
    }
  }
};

var styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#ffffff',
  },
  imageContainer: {
    position: 'absolute',
    top: -60,
    left: -110,
    margin: 0,
  },
  maskContainer: {
    margin: 10,
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#000033',
  },
  refMaskContainer: {
    position:'absolute',
    top: 0,
    bottom: 0,
    left: 0,
    right: 0,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: 'rgba(0,0,0,.7)',
  },
  viewContainer: {
    margin: 0,
    flex: 0,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#000033',
  },
  welcome: {
    flex:1,
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
    color: '#aaaaff',
  },
  instructions: {
    flex:1,
    paddingHorizontal:10,
    textAlign: 'center',
    color: '#aaaaff',
    marginBottom: 5,
  },
});

AppRegistry.registerComponent('MaskedViewDemo', () => MaskedViewDemo);
