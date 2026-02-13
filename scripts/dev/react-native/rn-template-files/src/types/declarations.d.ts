declare module "*.jpg" {
  const value: any;
  export default value;
}

declare module "*.png" {
  const value: any;
  export default value;
}

declare module "*.webp" {
  const value: any;
  export default value;
}

declare namespace JSX {
  type Element = import('react').ReactElement<any, any>;
  interface IntrinsicElements {
    [elemName: string]: any;
  }
}
