type Props = {
    label: string;
    onClick: () => void;
}
const Button : React.FC<Props> = ({label, onClick}) => {
    return(
        <button className="rounded-xl py-2 px-6 bg-blue-500 text-white" 
        onClick={onClick}>
          {label}
        </button>
    )
} 

export default Button