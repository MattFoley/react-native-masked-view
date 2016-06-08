/*
 * @providesModule MaskedView
 */


import React from 'react-native';

class MaskedView extends React.Component {
  render() {
    return (
      <RNMaskedView {...this.props}/>
    );
  }
}

MaskedView.propTypes = {
  maskImage: React.PropTypes.string,
  maskRefs: React.PropTypes.array,
  shouldUnionRefs: React.PropTypes.bool,
  maskCornerRadius: React.PropTypes.number,
  insets: React.PropTypes.object,
}

let RNMaskedView = React.requireNativeComponent('RNMaskedView', MaskedView);
export default MaskedView;
